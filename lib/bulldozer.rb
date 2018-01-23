require 'thor'
require 'aws-sdk'

require 'bulldozer/version'
require 'bulldozer/dsl'
require 'bulldozer/dsl/ec2'
require 'bulldozer/cli'

module Bulldozer
  Bulldozer::CLI.start
end
