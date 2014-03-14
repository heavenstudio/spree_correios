# Spree Correios

## :warning: Este projeto foi desenvolvido pra realizar um projeto específico, no entanto não é mais mantido :warning:

Uma extensão do [Spree](http://spreecommerce.com) para permitir cálculos de frete (Sedex e Pac, com ou sem contrato) utilizando o webservice dos correios, através da ótima gem [correios-frete](https://github.com/prodis/correios-frete). Esta gem supõe o uso de caixas retangulares, e não faz cálculos de embalagens em rolo ou prisma.

## Instalação

Adicione spree ao gemfile da sua aplicação, e também:

    gem "spree_correios"

## Configuração

Entre na seção administrativa do spree, vá em Configuração -> Métodos de Entrega e adicione o método de entrega desejado (SEDEX ou PAC). O atributo `CEP` é obrigatório e é utilizado como CEP de origem no cálculo do frete. Caso tenha um contrato com os correios, pode opcionalmente fornecer o `Código Administrativo` e a `Senha`.

A opção `Valor Declarado` utiliza o valor base do produto para declará-lo.

É necessário que os produtos que deseja disponibilizar para entrega através dos correios tenham os altura, largura, profundidade e peso corretamente preenchidos, pois estes atributos são utilizados para o cálculo do frete.

## TODO

* Adicionar dimensões do pacote aos produtos para cálculo do frete

## Contribuindo

Caso queira contribuir, faça um fork desta gem no [github](https://github.com/heavenstudio/spree_correios), corriga o bug/ adicione a feature desejada e faça um merge request.

## Testando

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

## Licença

Copyright (c) 2012 [Stefano Diem Benatti](mailto:stefano@heavenstudio.com.br), released under the New BSD License
