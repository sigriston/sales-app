require 'csv'
require 'header_converters'

class SalesController < ApplicationController
  def index
    @sales = Sale.all
    @grandtotal = Sale.grandtotal
  end

  def import
    if params[:file].present? and
        params[:file].instance_of? ActionDispatch::Http::UploadedFile
      file = params[:file]

      if file.content_type != "text/plain"
        redirect_to upload_sales_path, alert: "Arquivo Inválido!"
        return
      end

      begin
        data = CSV.read(file.open,
                        col_sep: "\t",
                        headers: true,
                        header_converters: :sales)
      rescue
        redirect_to upload_sales_path, alert: "Arquivo Inválido!"
        return
      end

      required_headers = HeaderConverters::HEADER_EQUIV.values
      headers_are_correct = (required_headers - data.headers).empty? &&
        (data.headers - required_headers).empty?

      if not headers_are_correct
        redirect_to upload_sales_path, alert: "Arquivo Inválido!"
        return
      end

      begin
        @sales = Sale.bulk_create_row(data)
      rescue ActiveRecord::RecordInvalid
        redirect_to upload_sales_path, alert: "Arquivo possui campos inválidos!"
        return
      end

      @grandtotal = @sales.map { |row| row.total }.reduce(:+)
    else
      redirect_to upload_sales_path, alert: "Faltando arquivo para upload!"
    end
  end
end
