#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Heading3 do
  alias Solace.Prismic.Types.Prismic.Heading3
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %Heading3{
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
    %Heading3{
      text: json["text"],
      spans: json["spans"] |> Prismic.parse_spans
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.Heading3

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Heading3 do
  def decode(entity, options \\ %{}) do
    if options[:no_wrap] do
      entity.text
    else
      "<h3 class=\"prismic\">" <> entity.text <> "</h3>"
    end
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Heading3
