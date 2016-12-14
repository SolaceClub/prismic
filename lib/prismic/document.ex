#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Document do
  alias Solace.Prismic.Document
  @vsn 0.01

  @type t :: %Document{
    type: atom,
    handle: atom,
    identifier: String.t,
    content: any,
    vsn: float
  }

  defstruct [
    type: nil,
    handle: nil,
    identifier: nil,
    content: nil,
    vsn: @vsn
  ]

end # end defmodule Solace.Prismic.Document
