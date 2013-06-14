module Spree
  class Calculator::CorreiosBaseCalculator < Calculator
    preference :zipcode, :string
    preference :token, :string
    preference :password, :string
    preference :declared_value, :boolean, default: false
    preference :receipt_notification, :boolean, default: false
    preference :receive_in_hands, :boolean, default: false
    
    attr_reader :delivery_time
    
    def compute(object)
      return unless object.present? and object.line_items.present?
      order = object.is_a?(Spree::Order) ? object : object.order

      itens = []
      order.line_items.map do |item|
        item.quantity.times do |n|
          itens << item
        end
      end

      package = ::Correios::Frete::Pacote.new
      itens.map do |item|
      order.line_items.map do |item|
        weight = item.product.weight.to_f
        depth  = item.product.depth.to_f
        width  = item.product.width.to_f
        height = item.product.height.to_f
        package_item = ::Correios::Frete::PacoteItem.new(peso: weight, comprimento: depth, largura: width, altura: height)
        package.add_item(package_item)
      end
      
      calculator = ::Correios::Frete::Calculador.new do |c| 
        c.cep_origem = preferred_zipcode
        c.cep_destino = order.ship_address.zipcode
        c.encomenda = package
        c.valor_declarado = order.amount.to_f if prefers?(:declared_value)
        c.mao_propria = prefers?(:receive_in_hands)
        c.aviso_recebimento = prefers?(:receipt_notification)
        c.codigo_empresa = preferred_token if preferred_token.present?
        c.senha = preferred_password if preferred_password.present?
      end
      
      webservice = calculator.calculate(shipping_method)
      return 0.0 if webservice.erro?
      @delivery_time = webservice.prazo_entrega
      webservice.valor
    rescue 0.0
    end
    
    def available?(order)
      !compute(order).zero?
    end
    
    def has_contract?
      preferred_token.present? && preferred_password.present?
    end
  end
end