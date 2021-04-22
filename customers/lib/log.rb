# frozen_string_literal: true

require 'logger'

module Log
  def log
    Log.log
  end

  def self.log
    @logger ||= Logger.new($stdout)
  end
end
