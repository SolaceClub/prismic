#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Heading4 do
  alias Solace.Prismic.Types.Prismic.Heading4
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %Heading4{
    text: String.t,
    spans: [],
    vsn: float
  }

  defstruct [
    text: nil,
    spans: [],
    vsn: @vsn
  ]

  def new(json) do
    %Heading4{
      text: json["text"],
      spans: json["spans"] |> Prismic.parse_spans
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.Heading4

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Heading4 do
  def decode(entity, options \\ %{}) do
    #TODO process span
    "<h4 class=\"prismic\">" <> entity.text <> "</h4>"
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Heading4
