defmodule Solace.PrismicTest do
  alias Solace.Prismic.Api
  use SolaceBackend.ComponentCase

  @prismic_type_inspiration "daily-inspirational-image"
  @prismic_type_affirmation "1"
  @prismic_type_item "inventory-item"
  @test_id "WEXp1iQAAAAIb_tQ"

  @tag :prismic
  test "Get Element By Id" do
    response = %Solace.Prismic.Types.CustomType{} = Api.new() |> Api.getById(@test_id)
  end

  @tag :prismic
  test "Get Element By uid" do
    response = %Solace.Prismic.Types.CustomType{} = Api.new() |> Api.getByUid("inventory-item", "solaceclub-self-care-box-grief-cards")
  end

  @tag :prismic
  test "Get Elements By Type" do
    response = %Solace.Prismic.Response{} = Api.new() |> Api.getByType("test")
    assert response.results_size == 1
  end

  @tag :prismic
  test "Verify SolaceClub Types" do
    response = %Solace.Prismic.Response{} = Api.new() |> Api.getByType("1") # inspiration
    assert response.results_size > 0

    response = %Solace.Prismic.Response{} = Api.new() |> Api.getByType("inventory-item")
    assert response.results_size > 0

    response = %Solace.Prismic.Response{} = Api.new() |> Api.getByType("package")
    assert response.results_size > 0

    response = %Solace.Prismic.Response{} = Api.new() |> Api.getByType("terms-of-service")
    assert response.results_size > 0
  end

end
