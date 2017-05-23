require 'csv'

module HeaderConverters
  header_equiv = {
    "Comprador"      => :customer,
    "Descrição"      => :description,
    "Preço Unitário" => :price,
    "Quantidade"     => :quantity,
    "Endereço"       => :address,
    "Fornecedor"     => :vendor
  }
  CSV::HeaderConverters[:sales] = lambda do |h|
    if header_equiv.has_key?(h)
      header_equiv[h]
    else
      CSV::HeaderConverters[:symbol].call h
    end
  end
end
