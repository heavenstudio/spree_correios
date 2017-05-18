module Spree
  class Calculator::PAC < Calculator::CorreiosBaseCalculator
   
    attr_accessible :preferred_zipcode, :preferred_token, :preferred_password, :preferred_declared_value, :preferred_receipt_notification, :preferred_receive_in_hands
   
    def self.description
      "PAC"
    end
    
    def shipping_method
      if has_contract?
        :pac_com_contrato
      else
        :pac
      end
    end
    
    def shipping_code
      if has_contract?
        41068
      else
        41106
      end
    end
  end
end
