# frozen_string_literal: true

require 'bunny'
require_relative 'log'

class ActionFactory
  def initialize
    @connection = Bunny.new
    @connection.start
    @channel = @connection.create_channel
    @queue = @channel.queue("outbound_actions")
  end

  def publish(action)
    return unless action
    Log.info(action)

    payload = {
      bank: action.band_id
      action: = action
    }
    @channel.default_exchange.publish(payload.to_json, routing_key: @queue.name)
  end
end
