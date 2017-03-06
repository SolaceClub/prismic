#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.ImageMeta do
  alias Solace.Prismic.Types.Prismic.ImageMeta
  alias Solace.Prismic.Types.Prismic.Image  
  @vsn 0.01

  @type t :: %ImageMeta{
    image: Image.t,
    views: any,
    vsn: float
  }

  defstruct [
    image: nil,
    views: nil,
    vsn: @vsn
  ]

  def parse_dimensions(json) do
    %{height: json["height"], width: json["width"]}
  end # end parse_dimensions/1

  def new(json) do
    %ImageMeta{
      image: json["value"]["main"] |> Image.new(),
      views: json["value"]["views"]
    }
  end # end new/1
end # end defmodule Solace.Prismic.Types.Prismic.ImageMeta

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.ImageMeta do
  def decode(entity, _options \\ %{}) do
    Solace.PrismicProtocol.decode(entity.image)
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.ImageMeta
