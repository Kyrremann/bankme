# frozen_string_literal: true

require 'faker'
require 'json'

class Customer
  attr_reader :bank, :name, :id, :balance

  def initialize(bank)
    @bank = bank
    @id = SecureRandom.hex(2)
    @name = Faker::Name.name
    @id_number = Faker::IDNumber.chilean_id
    @balance = rand(100_000)
  end

  def bank_level
    @bank.level
  end

  def as_json(options={})
    {
      name: @name,
      id_number: @id_number
    }
  end

  def to_json(*options)
    as_json(*options).to_json(*options)
  end
end
