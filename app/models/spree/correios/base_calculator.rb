module Spree
  module Correios
    class BaseCalculator < Spree::Calculator
      preference :zipcode, :string
      preference :token, :string
      preference :password, :password
      preference :declared_value, :boolean, default: false
      preference :receipt_notification, :boolean, default: false
      preference :receive_in_hands, :boolean, default: false
    end
  end
end