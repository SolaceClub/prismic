#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Embed do
  alias Solace.Prismic.Types.Prismic.Embed
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %Embed{
    oembed: any,
    vsn: float
  }

  defstruct [
    oembed: nil,
    vsn: @vsn
  ]

  def new(json) do
    %Embed{
      oembed: json["oembed"] |> Prismic.parse_item
    }
  end # end new/1
end # end defmodule Solace.Prismic.Types.Prismic.Embed

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Embed do
  def decode(entity, _options \\ %{}) do
    Solace.PrismicProtocol.decode(entity.oembed)
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Embed
