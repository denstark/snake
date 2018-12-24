require 'singleton'
require 'logger'

class SLogger
  include Singleton
  LOG_FILENAME = '/tmp/snake.log'
  attr_reader :logger
  
  def initialize
    @logger = Logger.new(LOG_FILENAME)
  end
end