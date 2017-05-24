#!/usr/bin/env ruby

require 'csv'
require 'faker'

CSV($stdout, col_sep: "\t") do |csv|
  csv << [
    "Comprador",
    "Descrição",
    "Preço Unitário",
    "Quantidade",
    "Endereço",
    "Fornecedor"
  ]

  5.times do
    csv << [
      Faker::Name.name,
      Faker::Commerce.product_name,
      Faker::Number.decimal(1, 2),
      Faker::Number.between(1, 12),
      Faker::Address.full_address,
      Faker::Company.name
    ]
  end
end
