#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Spans.Em do
  alias Solace.Prismic.Types.Prismic.Spans.Em
  @type t :: %Em{
    start: integer,
    end: integer,
  }

  defstruct [
    start: nil,
    end: nil
  ]

  def new(json) do
    %Em{
      start: json["start"],
      end: json["end"]
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.Spans.Em

defimpl Solace.PrismicSpanProtocol, for: Solace.Prismic.Types.Prismic.Spans.Em do
  def open(entity) do
    ~s(<em class="prismic">)
  end # end open/1
  def close(entity) do
    "</em>"
  end # end close/1
end # end defimpl Solace.PrismicSpanProtocol, for: Solace.Prismic.Types.Prismic.Spans.Em
