require 'csv'

module HeaderConverters
  HEADER_EQUIV = {
    "Comprador"      => :customer,
    "Descrição"      => :description,
    "Preço Unitário" => :price,
    "Quantidade"     => :quantity,
    "Endereço"       => :address,
    "Fornecedor"     => :vendor
  }
  CSV::HeaderConverters[:sales] = lambda do |h|
    if HEADER_EQUIV.has_key?(h)
      HEADER_EQUIV[h]
    else
      CSV::HeaderConverters[:symbol].call h
    end
  end
end
