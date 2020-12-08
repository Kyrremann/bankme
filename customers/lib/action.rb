# frozen_string_literal: true

require_relative 'log'

class Action
  def initialize(customer, name, input=nil)
    @customer = customer
    @name = name
    @input = input
  end

  def push
    if @input
      Log.info("#{@customer.bank_id}: #{@customer.name} (#{@customer.id}) is #{@name}(#{@input})")
    else
      Log.info("#{@customer.bank_id}: #{@customer.name} (#{@customer.id}) is #{@name}")
    end
  end

  def self.new_interaction(customer)
    case interaction_value(customer.level)
    when 0
      # - registrere ny kunde
      Action.new(customer, 'new_customer')
    when 1
      # - sjekke balansen
      Action.new(customer, 'check_balance')
    when 101
      # - sette inn penger
      Action.new(customer, 'deposit_money', rand(10_000))
    when 102
      # - ta ut penger
      Action.new(customer, 'withdraw_money', rand(100_000))
    else
      nil
    end
  end

  private
  def self.interaction_value(level)
    # todo - burde støtte mulighet for å delte interactions per level
    case level
    when 0
      rand(2)
    when 1
      rand(101..103)
    end
  end
end
