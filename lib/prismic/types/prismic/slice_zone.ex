#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.SliceZone do
  alias Solace.Prismic.Types.Prismic.SliceZone
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %SliceZone{
    value: [],
    vsn: float
  }

  defstruct [
    value: nil,
    vsn: @vsn
  ]

  def new(json) do
    %SliceZone{
      value: json["value"] |> Prismic.parse_item
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.SliceZone

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.SliceZone do
  def decode(entity, options \\ %{}) do
    Solace.PrismicProtocol.decode(entity.value, options)
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.SliceZone
