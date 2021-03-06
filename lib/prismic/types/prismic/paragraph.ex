#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Paragraph do
  alias Solace.Prismic.Types.Prismic.Paragraph
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %Paragraph{
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
    %Paragraph{
      text: json["text"],
      spans: json["spans"] |> Prismic.parse_spans
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.Paragraph

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Paragraph do
  alias Solace.Prismic.Types.Prismic
  def decode(entity, options \\ %{}) do
    text = entity.text
      |> Prismic.process_spans(entity.spans)
      |> Prismic.process_newlines()

    if options[:no_wrap] do
      text
    else
      "<p  class=\"prismic\">" <> text <> "</p>"
    end
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Paragraph
