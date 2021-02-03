# frozen_string_literal: true

require 'bunny'
require_relative 'log'

class ActionFactory
  def initialize
    @connection = Bunny.new
    @connection.start
    @channel = @connection.create_channel
  end

  def publish(action)
    return unless action
    Log.info(action)

    queue = @channel.queue(action.bank_id)
    @channel.default_exchange.publish(action.to_json, routing_key: queue.name)
  end
end
