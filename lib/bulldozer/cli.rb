module Bulldozer
  class CLI < Thor
    desc "start PATH", "create resource"
    def start(path)
      Bulldozer::DSL.load({}, path)
    end
  end
end
