# frozen_string_literal: true

class Customer
  attr_reader :bank_id, :name, :id, :balance

  def initialize(bank)
    @bank = bank
    @id = SecureRandom.hex(2)
    @name = Faker::Name.name
    @id_number = Faker::IDNumber.chilean_id
    @balance = rand(100_000)
  end

  def level
    @bank.level
  end
end
