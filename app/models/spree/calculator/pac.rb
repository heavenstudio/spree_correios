module Spree
  class Calculator::PAC < Calculator::CorreiosBaseCalculator
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
        04510
      end
    end
  end
end
