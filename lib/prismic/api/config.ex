#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Api.Config do
  @moduledoc """
    @TODO move into own repo.
  """
  alias Solace.Prismic.Api.Config
  @vsn 0.01

  @type t :: %Config{
    refs: any,
    bookmarks: any,
    types: any,
    tags: any,
    forms: any,
    oauth_initiate: any,
    oauth_token: any,
    version: any,
    license: any,
    experiments: any,
    vsn: float
  }

  defstruct [
    refs: nil,
    bookmarks: nil,
    types: nil,
    tags: nil,
    forms: nil,
    oauth_initiate: nil,
    oauth_token: nil,
    version: nil,
    license: nil,
    experiments: nil,
    vsn: @vsn
  ]

  def new(json) do
    %Config{
      refs: json["refs"],
      bookmarks: json["bookmarks"],
      types: json["types"],
      tags: json["tags"],
      forms: json["forms"],
      oauth_initiate: json["oauth_initiate"],
      oauth_token: json["oauth_token"],
      version: json["version"],
      license: json["license"],
      experiments: json["experiments"],
    }
  end # end new/1

  def ref(%Config{} = config, :master) do
    e = Enum.find(
      config.refs,
      fn(x) -> x["isMasterRef"] end
    )
    if e == nil do
      nil
    else
      e["ref"]
    end
  end # end ref/2

  def ref(%Config{} = config, handle) do
    e = Enum.find(
      config.refs,
      fn(x) -> x["id"] == handle end
    )
    if e == nil do
      nil
    else
      e["ref"]
    end
  end # end ref/2

end # end defmodule Solace.Prismic.Api.Config
