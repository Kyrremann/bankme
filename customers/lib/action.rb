# frozen_string_literal: true

require 'json'

class Action
  def initialize(customer)
    @customer = customer
    new_interaction
  end

  def bank_id
    @customer.bank.id
  end

  def inspect
    if @input
      "Action(#{@customer.bank.id}: #{@customer.name} (#{@customer.id}) is #{@action}(#{@input}))"
    else
      "Action(#{@customer.bank.id}: #{@customer.name} (#{@customer.id}) is #{@action})"
    end
  end

  def as_json(options={})
    json = {}
    json[:input] = @input if @input
    json = {
      action: @action,
      customer: @customer
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end

  private

  def new_interaction
    case interaction_value
    when 0
      # - registrere ny kunde
      @action = 'new_customer'
    when 1
      # - sjekke balansen
      @action = 'check_balance'
    when 101
      # - sette inn penger
      @action = 'deposit_money'
      @input = rand(10_000)
    when 102
      # - ta ut penger
      @action = 'withdraw_money'
      @input = rand(100_000)
    else
      nil
    end
  end

  def interaction_value
    # TODO: burde støtte mulighet for å delte interactions per level
    case @customer.bank_level
    when 0
      rand(2)
    when 1
      rand(101..103)
    end
  end
end
