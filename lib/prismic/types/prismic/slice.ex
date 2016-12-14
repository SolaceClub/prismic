#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Slice do
  alias Solace.Prismic.Types.Prismic.Slice
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %Slice{
    slice_label: String.t,
    slice_type: String.t,
    value: any,
    vsn: float
  }

  defstruct [
    slice_label: nil,
    slice_type: nil,
    value: nil,
    vsn: @vsn
  ]

  def new(json) do
    %Slice{
      slice_label: json["slice_label"],
      slice_type: json["slice_type"],
      value: json["value"] |> Prismic.parse_item,
    }
  end # end new/1


  defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Slice do
    def decode(entity, options \\ %{}) do
      Solace.PrismicProtocol.decode(entity.value, options)
    end # end decode/1
  end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Slice

end # end defmodule Solace.Prismic.Types.Prismic.Slice
