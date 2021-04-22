# frozen_string_literal: true

require 'faker'

require_relative 'log'
require_relative 'action'
require_relative 'action_factory'
require_relative 'bank'

class VirtualCustomer
  include Log

  def initialize
    @action_factory = ActionFactory.new
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
      break unless bank.time_for_new_action?

      log.info("#{bank.id}: Interacting with #{bank.name}")
      log.info("Created new customer: #{bank.new_customer!}") if create_new_customer?(bank)

      bank.customers.each do |customer|
        action = Action.new(customer)
        @action_factory.publish(action)
      end
      bank.action_completed!
    end
  end
end
