#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.CustomType do
  alias Solace.Prismic.Types.CustomType
  @vsn 0.01

  @type t :: %CustomType{
    id: String.t,
    uid: nil|String.t,
    type: String.t,
    href: String.t,
    tags: [String.t],
    first_publication_date: DateTime.t,
    last_publication_date: DateTime.t,
    slugs: [String.t],
    linked_documents: [],
    data: Map.t,
    ref: String.t,
    vsn: float
  }

  defstruct [
    id: nil,
    uid: nil,
    type: nil,
    href: nil,
    tags: [],
    first_publication_date: nil,
    last_publication_date: nil,
    slugs: [],
    linked_documents: [],
    data: %{},
    ref: nil,
    vsn: @vsn
  ]

  def new(json, ref) do
    %CustomType{
      id: json["id"],
      uid: json["uid"],
      type: json["type"],
      href: json["href"],
      tags: json["tags"],
      first_publication_date: json["first_publication_date"] |> Timex.parse!("{ISO:Extended}"),
      last_publication_date: json["last_publication_date"] |> Timex.parse!("{ISO:Extended}"),
      slugs: json["slugs"],
      linked_documents: json["linked_documents"],
      data: json["data"] |> parse_data,
      ref: ref
    }
  end # end new/2

  # TODO Centralize parse data. For reuse.
  def parse_data(nil) do
    %{}
  end # end parse_data/1

  def parse_data(json) do
    List.foldl(
      Map.keys(json),
      %{},
      fn(x, acc) ->
        Map.put(acc, x, parse_section(json[x]))
      end
    )
  end # end parse_data/1


  def parse_section(nil) do
    %{}
  end # end parse_section/1

  def parse_section(json) do
    List.foldl(
      Map.keys(json),
      %{},
      fn(x, acc) ->
        Map.put(acc, x, Solace.Prismic.Types.Prismic.parse_item(json[x]))
      end
    )
  end # end parse_section/1

end # end defmodule Solace.Prismic.Types.CustomType


defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.CustomType do
  def decode(entity, options \\ %{}) do
    "CustomType"
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.CustomType
