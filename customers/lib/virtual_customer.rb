# frozen_string_literal: true

require 'faker'

require_relative 'log'
require_relative 'action'
require_relative 'bank'

class VirtualCustomer
  def initialize
    @bank = Bank.new(Faker::Company.name)
  end

  def banks
    # get all banks in database
    [@bank]
  end

  def create_new_customer?(bank)
    bank.customers.empty? || rand(10) > 7
  end

  def interact_with_banks
    banks.each do |bank|
      return unless bank.time_for_new_action?
      Log.info("#{bank.id}: Interacting with #{bank.name}")

      if create_new_customer?(bank)
        bank.new_customer!
      end

      bank.customers.each do |customer|
        action = Action.new_interaction(customer)
        action.push if action
      end
      bank.action_completed!
    end
  end
end

