#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Image do
  alias Solace.Prismic.Types.Prismic.Image
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %Image{
    alt: String.t,
    copyright: String.t,
    dimensions: String.t,
    type: String.t,
    url: String.t,
    vsn: float
  }

  defstruct [
    alt: nil,
    copyright: nil,
    dimensions: nil,
    type: nil,
    url: nil,
    vsn: @vsn
  ]

  def parse_dimensions(json) do
    %{height: json["height"], width: json["width"]}
  end # end parse_dimensions/1

  def new(json) do
    %Image{
      alt: json["alt"],
      copyright: json["copyright"],
      dimensions: json["dimensions"] |> parse_dimensions(),
      url: json["url"]
    }
  end # end new/1
end # end defmodule Solace.Prismic.Types.Prismic.Image

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Image do
  def decode(entity, options \\ %{}) do
    style = case entity.dimensions do
      %{height: nil, width: nil} -> ""
      %{height: height, width: nil} -> ~s(style="height:#{height};")
      %{height: nil, width: width} -> ~s(style="width:#{width};")
      %{height: height, width: width} -> ~s(style="height:#{height};width:#{width};")
    end
    ~s(<img  class=\"prismic\" src="#{entity.url}" #{style} alt="#{entity.alt}"/>)
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Image
