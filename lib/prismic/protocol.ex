#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

#----------------------------------------------------------------
# Protocols
#----------------------------------------------------------------
defprotocol Solace.Prismic.UrlEncodeProtocol do
  def encode(entity)
end # end defprotocol Solace.Prismic.UrlEncodeProtocol

defprotocol Solace.PrismicProtocol do
  @fallback_to_any true
  def decode(entity, options \\ %{})
end # end defprotocol Solace.PrismicProtocol

defprotocol Solace.PrismicSpanProtocol do
  @fallback_to_any true
  def open(entity)
  def close(entity)
end # end defprotocol Solace.PrismicSpanProtocol


defprotocol Solace.PrismicResultProtocol do
  @fallback_to_any true
  def next(entity)
end # end defprotocol Solace.PrismicResultProtocol


#----------------------------------------------------------------
# Solace.PrismicProtocol
#----------------------------------------------------------------
defimpl Solace.PrismicProtocol, for: List do
  def decode(entries, options \\ %{}) do
    List.foldl(
      entries,
      "",
      fn(x, acc) ->
        acc <> Solace.PrismicProtocol.decode(x, options)
      end
    )
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: List

defimpl Solace.PrismicProtocol, for: Map do
  def decode(entity, _options \\ %{}) do
    "#{inspect entity}"
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Map

defimpl Solace.PrismicProtocol, for: Any do
  def decode(entity, _options \\ %{}) do
    "#{inspect entity}"
  end # end decode/1
end # end defimpl Solace.PrismicProtocol, for: Any

#----------------------------------------------------------------
# Solace.PrismicSpanProtocol
#----------------------------------------------------------------
defimpl Solace.PrismicSpanProtocol, for: Any do
  def open(_options) do
    ~s(<span class="unknown">)
  end # end open/1
  def close(_options) do
    "</span>"
  end # end close/1
end # end defimpl Solace.PrismicSpanProtocol, for: Any

#----------------------------------------------------------------
# Solace.PrismicResultProtocol
#----------------------------------------------------------------
defimpl Solace.PrismicResultProtocol, for: Any do
  def next(_entity) do
    nil
  end # end next/1
end # end defimpl Solace.PrismicResultProtocol, for: Any
