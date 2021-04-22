# frozen_string_literal: true

require 'securerandom'

require_relative 'customer'

class Bank
  attr_reader :name, :id, :level, :customers

  def initialize(name)
    @name = name
    @id = SecureRandom.hex(3)
    @next_time_for_action = Time.now
    @level = 0
    @customers = []
  end

  def time_for_new_action?
    @next_time_for_action <= Time.now
  end

  def new_customer!
    customer = Customer.new(self)
    @customers << customer
    customer
  end

  def action_completed!
    @next_time_for_action = Time.now + rand(4) + 8
  end
end
