module Spree
  module Calculator::Shipping
    class CorreiosBaseCalculator < Spree::ShippingCalculator
      # preference :token, :string
      # preference :password, :string
      # preference :declared_value, :boolean, default: false
      # preference :receipt_notification, :boolean, default: false
      # preference :receive_in_hands, :boolean, default: false
      
      attr_reader :delivery_time
      
      def compute(package)
        return unless package.present?
          order = package.order

          return unless order.line_items.present?

          pack = ::Correios::Frete::Pacote.new
          package.contents.each do |item|
            item = item.variant
            weight = item.weight.to_f
            depth  = item.depth.to_f
            width  = item.width.to_f
            height = item.height.to_f
            package_item = ::Correios::Frete::PacoteItem.new(peso: weight, comprimento: depth, largura: width, altura: height)
            pack.add_item(package_item)
          end

          calculator = ::Correios::Frete::Calculador.new do |c|
            c.cep_origem = package.stock_location.zipcode
            c.cep_destino = order.ship_address.zipcode
            c.encomenda = pack
            # c.valor_declarado = order.amount.to_f if prefers?(:declared_value)
            # c.mao_propria = prefers?(:receive_in_hands)
            # c.aviso_recebimento = prefers?(:receipt_notification)
            # c.codigo_empresa = preferred_token if preferred_token.present?
            # c.senha = preferred_password if preferred_password.present?
          end

          webservice = calculator.calculate(:shipping_method)
          return 0.0 if webservice.erro?
          @delivery_time = webservice.prazo_entrega
          webservice.valor
      end
      
      def available?(order)
        !compute(order).zero?
      end
      
      def has_contract?
        false # preferred_token.present? && preferred_password.present?
      end
    end
  end
end