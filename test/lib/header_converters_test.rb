require 'test_helper'
require 'csv'
require 'header_converters'

class HeaderConvertersTest < ActiveSupport::TestCase
  setup do
    @csv = "Comprador,Descrição,Preço Unitário,Quantidade,Endereço,Fornecedor\nJoão Silva,R$10 off R$20 of food,10.0,2,987 Fake St,Bob's Pizza"
    @csv_bad = "Descrição,Preço Unitário,Compradora,Quantidade,Endereço,Fornecedor\nR$10 off R$20 of food,10.0,João Silva,2,987 Fake St,Bob's Pizza"
  end

  test "simple conversion" do
    parsed = CSV.parse(@csv, headers: true, header_converters: :sales)
    assert_equal [
      :customer,
      :description,
      :price,
      :quantity,
      :address,
      :vendor
    ], parsed.headers
  end

  test "conversion with mismatching column name" do
    parsed = CSV.parse(@csv_bad, headers: true, header_converters: :sales)
    assert_equal [
      :description,
      :price,
      :compradora,
      :quantity,
      :address,
      :vendor
    ], parsed.headers
  end
end
