#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Heading6 do
  alias Solace.Prismic.Types.Prismic.Heading6
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %Heading6{
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
    %Heading6{
      text: json["text"],
      spans: json["spans"] |> Prismic.parse_spans
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.Heading6

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Heading6 do
  def decode(entity, options \\ %{}) do
    if options[:no_wrap] do
      entity.text
    else
      "<h6 class=\"prismic\">" <> entity.text <> "</h6>"
    end
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Heading6
