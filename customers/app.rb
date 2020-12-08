# frozen_string_literal: true

require './lib/virtual_customer'

vc = VirtualCustomer.new

loop do
  vc.interact_with_banks
end
