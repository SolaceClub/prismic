#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Video do
  alias Solace.Prismic.Types.Prismic.Video
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  def data do
    %{"oembed" => %{
        "author_name" => "Louis C.K.",
        "author_url" => "https://www.youtube.com/channel/UCXhXCoEXZhahE602TbFk-AQ",
        "embed_url" => "https://www.youtube.com/watch?v=CLdCkU0eeKo",
        "height" => 270,
        "html" => "<iframe width=\"480\" height=\"270\" src=\"https://www.youtube.com/embed/CLdCkU0eeKo?feature=oembed\" frameborder=\"0\" allowfullscreen></iframe>",
        "provider_name" => "YouTube", "provider_url" => "https://www.youtube.com/",
        "thumbnail_height" => 360,
        "thumbnail_url" => "https://i.ytimg.com/vi/CLdCkU0eeKo/hqdefault.jpg",
        "thumbnail_width" => 480, "title" => "Louis CK  - I Said Yes Yes",
        "type" => "video", "version" => "1.0", "width" => 480
        },
        "type" => "embed"
      }
  end # end data/0

  @type t :: %Video{
    author_name: String.t,
    author_url: String.t,
    embed_url: String.t,
    height: integer,
    width: integer,
    html: String.t,
    provider_name: String.t,
    thumbnail_height: integer,
    thumbnail_url: String.t,
    thumbnail_width: integer,
    title: String.t,
    version: String.t,
    vsn: float
  }

  defstruct [
    author_name: nil,
    author_url: nil,
    embed_url: nil,
    height: nil,
    width: nil,
    html: nil,
    provider_name: nil,
    thumbnail_height: nil,
    thumbnail_url: nil,
    thumbnail_width: nil,
    title: nil,
    version: nil,
    vsn: @vsn
  ]

  def new(json) do
    %Video{
      author_name: json["author_name"],
      author_url: json["author_url"],
      embed_url: json["embed_url"],
      height: json["height"],
      width: json["width"],
      html: json["html"],
      provider_name: json["provider_name"],
      thumbnail_height: json["thumbnail_height"],
      thumbnail_url: json["thumbnail_url"],
      thumbnail_width: json["thumbnail_width"],
      title: json["title"],
      version: json["version"],
    }
  end # end new/1
end # end defmodule Solace.Prismic.Types.Prismic.Video

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Video do
  def decode(entity, options \\ %{}) do
    entity.html
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Video
