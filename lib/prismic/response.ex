#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Response do
  @moduledoc """
    @TODO move into own repo.
  """
  alias Solace.Prismic.Response
  alias Solace.Prismic.Types.CustomType
  @vsn 0.01

  @type t :: %Response{
    page: integer,
    results_per_page: integer,
    results_size: integer,
    total_results_size: integer,
    total_pages: integer,
    next_page: String.t,
    prev_page: String.t,
    results: [],
    version: String.t,
    license: String.t,
    ref: String.t,
    vsn: float
  }

  defstruct [
    page: nil,
    results_per_page: nil,
    results_size: nil,
    total_results_size: nil,
    total_pages: nil,
    next_page: nil,
    prev_page: nil,
    results: [],
    version: nil,
    license: nil,
    ref: nil,
    vsn: @vsn
  ]

  def new(json, ref) do
    %Response{
      page: json["page"],
      results_per_page: json["results_per_page"],
      results_size: json["results_size"],
      total_results_size: json["total_results_size"],
      total_pages: json["total_pages"],
      next_page: json["next_page"],
      prev_page: json["prev_page"],
      results: json["results"] |> parse_results(ref),
      version: json["version"],
      license: json["license"],
      ref: ref
    }
  end # end new/2

  def parse_results(nil, _ref) do
    []
  end # end parse_results/2

  def parse_results(results, ref) when is_list(results) do
    for result <- results do
      parse_result(result, ref)
    end
  end # end parse_results/2

  def parse_result(json, ref) do
    case json["type"] do
      _ -> CustomType.new(json, ref)
    end
  end # end parse_result/2

end # end defmodule Solace.Prismic.Response



#----------------------------------------------------------------
# Solace.PrismicResultProtocol
#----------------------------------------------------------------
defimpl Solace.PrismicResultProtocol, for: Solace.Prismic.Response do

  def next(%Solace.Prismic.Response{next_page: nil}) do
    nil
  end # end next/1

  def next(%Solace.Prismic.Response{next_page: continuation, ref: ref}) do
    case HTTPoison.get(continuation) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
          |> Poison.decode!()
          |> Solace.Prismic.Response.new(ref)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %HTTPoison.Error{reason: reason}}
    end
  end # end next/1

end # end defimpl Solace.PrismicResultProtocol, for: Solace.Prismic.Response
