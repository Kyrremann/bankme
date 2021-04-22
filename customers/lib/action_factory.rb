# frozen_string_literal: true

require 'bunny'

require_relative 'action'
require_relative 'log'

class ActionFactory
  include Log

  def initialize
    @connection = Bunny.new
    @connection.start
    @channel = @connection.create_channel
    @queue = @channel.queue("outbound_actions")
  end

  def new_interaction(customer)
    Action.new(customer)
  end

  def publish(action)
    return unless action
    log.info(action)

    payload = {
      bank: action.bank_id,
      action: action
    }
    @channel.default_exchange.publish(payload.to_json, routing_key: @queue.name)
  end
end
