#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Spans.Strong do
  alias Solace.Prismic.Types.Prismic.Spans.Strong
  @type t :: %Strong{
    start: integer,
    end: integer,
  }

  defstruct [
    start: nil,
    end: nil
  ]

  def new(json) do
    %Strong{
      start: json["start"],
      end: json["end"]
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.Spans.Strong

defimpl Solace.PrismicSpanProtocol, for: Solace.Prismic.Types.Prismic.Spans.Strong do
  def open(_entity) do
    ~s(<strong class="prismic">)
  end # end open/1
  def close(_entity) do
    "</strong>"
  end # end close/1
end # end defimpl Solace.PrismicSpanProtocol, for: Solace.Prismic.Types.Prismic.Spans.Strong
