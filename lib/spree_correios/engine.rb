module SpreeCorreios
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_correios'

    config.autoload_paths += %W(#{config.root}/lib)

    initializer "spree.register.correios_calculator", after: "spree.register.calculators" do |app|
      app.config.spree.calculators.shipping_methods += [Spree::Calculator::Shipping::SEDEX, Spree::Calculator::Shipping::PAC, Spree::Calculator::Shipping::SEDEX10]
    end

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/models/**/*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
