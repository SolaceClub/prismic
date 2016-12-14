#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.LinkImage do
  alias Solace.Prismic.Types.Prismic.LinkImage
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %LinkImage{
    image: any,
    vsn: float
  }

  defstruct [
    image: nil,
    vsn: @vsn
  ]

  def new(json) do
    image = %{
      height: json["value"]["image"]["height"],
      kind: json["value"]["image"]["kind"],
      name: json["value"]["image"]["name"],
      size: json["value"]["image"]["size"],
      url: json["value"]["image"]["url"],
      width: json["value"]["image"]["width"],
    }

    %LinkImage{
      image: image
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.LinkImage

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.LinkImage do
  def decode(entity, options \\ %{}) do
    #TODO process span
    "<pre  class=\"prismic\">#{inspect entity}</pre>"
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.LinkImage
