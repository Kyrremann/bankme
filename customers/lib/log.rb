require 'logger'

module Log
  def self.logger
    if @logger.nil?
      @logger = Logger.new( STDOUT)
    end
    @logger
  end

  def self.logger=(logger)
    @logger = logger
  end

  levels = %w(debug info warn error fatal)
  levels.each do |level|
    define_method( "#{level.to_sym}") do |msg|
      self.logger.send(level, msg)
    end
  end
end

include Log
