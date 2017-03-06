#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Text do
  alias Solace.Prismic.Types.Prismic.Text
  @vsn 0.01

  @type t :: %Text{
    text: String.t,
    vsn: float
  }

  defstruct [
    text: nil,
    vsn: @vsn
  ]

  def new(json) do
    %Text{
      text: json["value"],
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.Text

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Text do
  def decode(entity, _options \\ %{}) do
    entity.text
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Text
