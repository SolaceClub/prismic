#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Spans.HyperLink do
  alias Solace.Prismic.Types.Prismic.Spans.HyperLink
  alias Solace.Prismic.Types.Prismic

  @type t :: %HyperLink{
    start: integer,
    end: integer,
    data: any
  }

  defstruct [
    start: nil,
    end: nil,
    data: nil
  ]

  def new(json) do
    %HyperLink{
      start: json["start"],
      end: json["end"],
      data: json["data"]  |> Prismic.parse_item
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.Spans.HyperLink

defimpl Solace.PrismicSpanProtocol, for: Solace.Prismic.Types.Prismic.Spans.HyperLink do
  alias Solace.Prismic.Types.Prismic.LinkWeb
  alias Solace.Prismic.Types.Prismic.LinkImage

  def open(entity) do
    case entity.data do
      %LinkWeb{} ->
        ~s(<a class="prismic" href="#{entity.data.url}" >)
      %LinkImage{} ->
        ~s(<a class="prismic" href="#{entity.data.image.url}">)
    end
  end # end open/1

  def close(entity) do
    "</a>"
  end # end close/1
end # end defimpl Solace.PrismicSpanProtocol, for: Solace.Prismic.Types.Prismic.Spans.HyperLink
