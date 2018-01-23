require 'thor'
require 'aws-sdk'

require 'bulldozer/version'
require 'bulldozer/dsl'
require 'bulldozer/structure/ec2'
require 'bulldozer/structure/s3'
require 'bulldozer/cli'

module Bulldozer
  Bulldozer::CLI.start
end
