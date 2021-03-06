require 'test_helper'

class SalesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get sales_path
    assert_response :success
  end

  test "index with no data" do
    Sale.delete_all
    get sales_path

    assert_select "h3", "Nenhum registro encontrado!"
    assert_response :success
  end

  test "index with fixture data" do
    get sales_path

    assert_select "table#sales-table"

    # headers
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(1)",
      "Comprador"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(2)",
      "Fornecedor"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(3)",
      "Endereço"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(4)",
      "Descrição"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(5)",
      "Preço Unitário"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(6)",
      "Quantidade"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(7)",
      "Preço Total"

    # data
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(1)",
      "Sicrano de Tal"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(2)",
      "Shi Qiang"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(3)",
      "No. 51 Weijin South Road"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(4)",
      "Mac and Cheese"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(5)",
      "$10.95"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(6)",
      "5"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(7)",
      "$54.75"

    assert_select "table#sales-table tr:nth-child(3) td:nth-child(1)",
      "Fulano de Tal"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(2)",
      "Ye Wenjie"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(3)",
      "Tsinghua University"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(4)",
      "BLT"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(5)",
      "$7.99"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(6)",
      "3"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(7)",
      "$23.97"

    # grandtotal
    assert_select "table#sales-table tr:nth-child(4) th:nth-child(1)",
      "Total em Vendas"
    assert_select "table#sales-table tr:nth-child(4) th:nth-child(2)",
      "$78.72"

    assert_response :success
  end

  test "should get upload" do
    get upload_sales_path
    assert_response :success
  end

  test "import with no file should redirect to upload" do
    post import_sales_path
    assert_redirected_to upload_sales_path
    follow_redirect!
    assert_response :success
    assert_select ".alert.alert-danger", "Faltando arquivo para upload!"
  end

  test "import with file should work ok" do
    post import_sales_path, params: {
      file: fixture_file_upload('files/dados.txt', 'text/plain')
    }
    assert_response :success
  end

  test "import with file should have data" do
    post import_sales_path, params: {
      file: fixture_file_upload('files/dados.txt', 'text/plain')
    }

    assert_select "table#sales-table"

    # headers
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(1)",
      "Comprador"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(2)",
      "Fornecedor"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(3)",
      "Endereço"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(4)",
      "Descrição"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(5)",
      "Preço Unitário"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(6)",
      "Quantidade"
    assert_select "table#sales-table tr:nth-child(1) th:nth-child(7)",
      "Preço Total"

    # data
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(1)",
      "João Silva"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(2)",
      "Bob's Pizza"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(3)",
      "987 Fake St"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(4)",
      "R$10 off R$20 of food"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(5)",
      "$10.00"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(6)",
      "2"
    assert_select "table#sales-table tr:nth-child(2) td:nth-child(7)",
      "$20.00"

    assert_select "table#sales-table tr:nth-child(3) td:nth-child(1)",
      "Amy Pond"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(2)",
      "Tom's Awesome Shop"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(3)",
      "456 Unreal Rd"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(4)",
      "R$30 of awesome for R$10"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(5)",
      "$10.00"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(6)",
      "5"
    assert_select "table#sales-table tr:nth-child(3) td:nth-child(7)",
      "$50.00"

    assert_select "table#sales-table tr:nth-child(4) td:nth-child(1)",
      "Marty McFly"
    assert_select "table#sales-table tr:nth-child(4) td:nth-child(2)",
      "Sneaker Store Emporium"
    assert_select "table#sales-table tr:nth-child(4) td:nth-child(3)",
      "123 Fake St"
    assert_select "table#sales-table tr:nth-child(4) td:nth-child(4)",
      "R$20 Sneakers for R$5"
    assert_select "table#sales-table tr:nth-child(4) td:nth-child(5)",
      "$5.00"
    assert_select "table#sales-table tr:nth-child(4) td:nth-child(6)",
      "1"
    assert_select "table#sales-table tr:nth-child(4) td:nth-child(7)",
      "$5.00"

    assert_select "table#sales-table tr:nth-child(5) td:nth-child(1)",
      "Snake Plissken"
    assert_select "table#sales-table tr:nth-child(5) td:nth-child(2)",
      "Sneaker Store Emporium"
    assert_select "table#sales-table tr:nth-child(5) td:nth-child(3)",
      "123 Fake St"
    assert_select "table#sales-table tr:nth-child(5) td:nth-child(4)",
      "R$20 Sneakers for R$5"
    assert_select "table#sales-table tr:nth-child(5) td:nth-child(5)",
      "$5.00"
    assert_select "table#sales-table tr:nth-child(5) td:nth-child(6)",
      "4"
    assert_select "table#sales-table tr:nth-child(5) td:nth-child(7)",
      "$20.00"

    # grandtotal
    assert_select "table#sales-table tr:nth-child(6) th:nth-child(1)",
      "Total em Vendas"
    assert_select "table#sales-table tr:nth-child(6) th:nth-child(2)",
      "$95.00"
  end

  test "import with malformed text file" do
    post import_sales_path, params: {
      file: fixture_file_upload('files/shakes.txt', 'text/plain')
    }
    assert_redirected_to upload_sales_path
    follow_redirect!
    assert_response :success
    assert_select ".alert.alert-danger", "Arquivo Inválido!"
  end

  test "import with image file" do
    post import_sales_path, params: {
      file: fixture_file_upload('files/rails.png', 'image/png')
    }
    assert_redirected_to upload_sales_path
    follow_redirect!
    assert_response :success
    assert_select ".alert.alert-danger", "Arquivo Inválido!"
  end

  test "import with image file but text MIME type" do
    post import_sales_path, params: {
      file: fixture_file_upload('files/rails.png', 'text/plain')
    }
    assert_redirected_to upload_sales_path
    follow_redirect!
    assert_response :success
    assert_select ".alert.alert-danger", "Arquivo Inválido!"
  end

  test "import with malformed file param" do
    post import_sales_path, params: { file: "not a file!" }
    assert_redirected_to upload_sales_path
    follow_redirect!
    assert_response :success
    assert_select ".alert.alert-danger", "Faltando arquivo para upload!"
  end

  test "import with invalid fields" do
    post import_sales_path, params: {
      file: fixture_file_upload('files/dados_bad.txt', 'text/plain')
    }

    assert_redirected_to upload_sales_path
    follow_redirect!
    assert_response :success
    assert_select ".alert.alert-danger", "Arquivo possui campos inválidos!"
  end
end
