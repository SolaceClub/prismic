#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.StructuredText do
  alias Solace.Prismic.Types.Prismic.StructuredText
  @vsn 0.01

  @type t :: %StructuredText{
    value: [],
    vsn: float
  }

  defstruct [
    value: [],
    vsn: @vsn
  ]

  def new(json) do

    value = case json["value"] do
      :nil -> []
      m -> Solace.Prismic.Types.Prismic.parse_item(m)
    end

    %StructuredText{
      value: value
    }
  end # end new/1
end # end defmodule Solace.Prismic.Types.Prismic.StructuredText


defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.StructuredText do
  def decode(entity, options \\ %{}) do
    Solace.PrismicProtocol.decode(entity.value, options)
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.StructuredText
