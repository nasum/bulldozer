module Bulldozer
  class DSL
    attr_reader :options, :structure

    DEFAULT = {
      access_key: ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: ENV['AWS_DEFAULT_REGION']
    }.map { |k, v| [k, v.freeze] }.to_h.freeze

    STRUCTURE = "structure.json".freeze

    def initialize(options)
      @options = DEFAULT.dup
      @options.merge!(options)
    end

    def self.load(options, path = nil)
      new(options).tap do |obj|
        obj._load_from(path)
      end.options
    end

    def init(bucket_name)
      s3 = Bulldozer::Structure::S3.new(@options)

      resp = s3.get(bucket_name, STRUCTURE)
      @structure = JSON.load(resp.body.read) if resp

      unless @structure
        _create_bucket(bucket_name)
      end

      puts "blue print bucket: #{bucket_name}"
    end

    def _create_bucket(bucket_name)
      s3 = Bulldozer::Structure::S3.new(@options)
      resp = s3.create(bucket_name)
      @structure = "{}"
      s3.put(bucket_name, STRUCTURE, @structure)
    end

    def _load_from(path)
      instance_eval(File.read(path), path) if path
    end
  end
end
