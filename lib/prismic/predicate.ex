#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Predicate do
  @moduledoc """
    @TODO move into own repo.
  """
  alias Solace.Prismic.Predicate
  @vsn 0.01

  @type t :: %Predicate{
    type: String.t,
    entry: String.t,
    predicate: String.t
  }

  defstruct [
    type: nil,
    entry: nil,
    predicate: @vsn
  ]

  def at(entry, predicate) do
    %Predicate{
      type: :at,
      entry: entry,
      predicate: predicate
    }
  end # end at/2

  def any(entry, predicate) do
    %Predicate{
      type: :any,
      entry: entry,
      predicate: predicate
    }
  end # end any/2
end # end defmodule Solace.Prismic.Predicate

defimpl Solace.Prismic.UrlEncodeProtocol, for: Solace.Prismic.Predicate do
  def encode(entity) do
    "[:d = #{entity.type}(#{entity.entry}, \"#{entity.predicate}\")]"
  end # end encode/1
end # end defimpl Solace.Prismic.UrlEncodeProtocol, for: Solace.Prismic.Predicate
