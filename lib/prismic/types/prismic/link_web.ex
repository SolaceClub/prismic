#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.LinkWeb do
  alias Solace.Prismic.Types.Prismic.LinkWeb
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %LinkWeb{
    url: String.t,
    vsn: float
  }

  defstruct [
    url: nil,
    vsn: @vsn
  ]

  def new(json) do
    %LinkWeb{
      url: json["value"]["url"]
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.LinkWeb



defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.LinkWeb do
  def decode(entity, options \\ %{}) do
    #TODO process span
    ~s(<a  class=\"prismic\" href="#{entity.url}">#{entity.url}</a>)
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.LinkWeb
