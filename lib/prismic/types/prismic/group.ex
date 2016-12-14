#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic.Group do
  alias Solace.Prismic.Types.Prismic.Group
  alias Solace.Prismic.Types.Prismic
  @vsn 0.01

  @type t :: %Group{
    value: any,
    vsn: float
  }

  defstruct [
    value: nil,
    vsn: @vsn
  ]

  def parse_group_value(json) when is_list(json) do
    for e <- json do
      parse_group_value(e)
    end
  end # end parse_group_value/1

  def parse_group_value(json) do
    List.foldl(
      Map.keys(json),
      %{},
      fn(x, acc) ->
        Map.put(acc, x, Prismic.parse_item(json[x]))
      end
    )
  end # end parse_group_value/1

  def new(json) do
    %Group{
      value: json["value"] |> parse_group_value,
    }
  end # end new/1

end # end defmodule Solace.Prismic.Types.Prismic.Group

defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Group do
  def decode(entity, options \\ %{}) do
    #TODO process span
    if options[:no_wrap] do
      "#{inspect entity}"
    else
      ~s(<pre class="prismic">#{inspect entity}</pre>)
    end

  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Solace.Prismic.Types.Prismic.Group
