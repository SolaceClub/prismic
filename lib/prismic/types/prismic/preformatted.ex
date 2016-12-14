#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Preformatted do
  alias Solace.Prismic.Types.Prismic.Preformatted
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %Preformatted{
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
    %Preformatted{
      text: json["text"],
      spans: json["spans"] |> Prismic.parse_spans
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.Preformatted

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Preformatted do
  alias Solace.Prismic.Types.Prismic
  def decode(entity) do
    text = entity.text
      |> Prismic.process_spans(entity.spans)
      |> Prismic.process_newlines()
    "<pre  class=\"prismic\">" <> text <> "</pre>"
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Preformatted
