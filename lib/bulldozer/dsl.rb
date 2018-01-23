module Bulldozer
  class DSL
    attr_reader :options

    DEFAULT = {
      access_key: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_DEFAULT_REGION']
    }.map { |k, v| [k, v.freeze] }.to_h.freeze

    def self.load(options, path = nil)
      new(options).tap do |obj|
        obj._load_from(path)
      end.options
    end

    def initialize(options)
      @options = DEFAULT.dup
      @options.merge!(options)
    end

    def _load_from(path)
      instance_eval(File.read(path), path) if path
    end

    def show_options
      puts @options
    end
  end
end
