require 'csv'
require 'header_converters'

class SalesController < ApplicationController
  def index
    @sales = Sale.all
    @grandtotal = Sale.grandtotal
  end

  def import
    if params.has_key?("file")
      file = params[:file]
      data = CSV.read(file.open,
                      col_sep: "\t",
                      headers: true,
                      header_converters: :sales)

      @sales = Sale.bulk_create_row(data)
      @grandtotal = @sales.map { |row| row.total }.reduce(:+)
    else
      redirect_to upload_sales_path, alert: "Faltando arquivo para upload!"
    end
  end
end
