#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Types.Prismic do
  alias Solace.Prismic.Types.Prismic.StructuredText
  alias Solace.Prismic.Types.Prismic.Paragraph
  alias Solace.Prismic.Types.Prismic.ListItem
  alias Solace.Prismic.Types.Prismic.OListItem
  alias Solace.Prismic.Types.Prismic.Heading1
  alias Solace.Prismic.Types.Prismic.Heading2
  alias Solace.Prismic.Types.Prismic.Heading3
  alias Solace.Prismic.Types.Prismic.Heading4
  alias Solace.Prismic.Types.Prismic.Heading5
  alias Solace.Prismic.Types.Prismic.Heading6
  alias Solace.Prismic.Types.Prismic.LinkImage
  alias Solace.Prismic.Types.Prismic.Embed
  alias Solace.Prismic.Types.Prismic.Video
  alias Solace.Prismic.Types.Prismic.Slice
  alias Solace.Prismic.Types.Prismic.SliceZone
  alias Solace.Prismic.Types.Prismic.Group
  alias Solace.Prismic.Types.Prismic.Image
  alias Solace.Prismic.Types.Prismic.ImageMeta
  alias Solace.Prismic.Types.Prismic.LinkWeb
  alias Solace.Prismic.Types.Prismic.Text
  alias Solace.Prismic.Types.Prismic.Preformatted

  alias Solace.Prismic.Types.Prismic.Spans


  def process_spans(text, nil = _spans) do
    text
  end # end process_spans/2

  def process_spans(text, [] = _spans) do
    text
  end # end process_spans/2

  def process_spans(text, spans) when is_list(spans) do
    # Insure Spans are sorted by start
    spans = Enum.sort(spans,
      fn(a,b) ->
        (a.start < b.start) || ((a.start == b.start) && (a.end < b.end))
      end
    )

    instructions = List.foldl(
      spans,
      %{},
      fn(x, acc) ->
        o = Solace.PrismicSpanProtocol.open(x)
        c = Solace.PrismicSpanProtocol.close(x)
        acc
          |> Map.update(x.start, o, fn(p) -> p <> o end)
          |> Map.update(x.end, c, fn(p) -> c <> p end)
      end
    )

    slices = instructions |> Map.keys |> Enum.sort

    {pos, acc} = List.foldl(slices, {0,""},
      fn(i, {pos, acc}) ->
        # Append text pos to i to acc. append instructions, update pos.
        if (i == pos) do
          {i, acc <> instructions[i]}
        else
          {i, acc <> String.slice(text, pos..(i-1)) <> instructions[i]}
        end
      end
    )
    acc <> String.slice(text, (pos)..-1)
  end # end process_spans/2


  def process_newlines(text) do
    text
      |> String.replace("\n", "</br>")
  end # end process_newlines/1

  def parse_item(json) when is_list(json) do
    for j <- json do
      parse_item(j)
    end
  end # end parse_item/1

  def parse_item(json) do


    case json["type"] do
      "StructuredText" ->  StructuredText.new(json)
      "paragraph" ->  Paragraph.new(json)
      "list-item" ->  ListItem.new(json)
      "o-list-item" ->  OListItem.new(json)
      "heading1" ->  Heading1.new(json)
      "heading2" ->  Heading2.new(json)
      "heading3" ->  Heading3.new(json)
      "heading4" ->  Heading4.new(json)
      "heading5" ->  Heading5.new(json)
      "heading6" ->  Heading6.new(json)
      "Link.image" -> LinkImage.new(json)
      "Link.web" -> LinkWeb.new(json)
      "SliceZone" -> SliceZone.new(json)
      "Slice" -> Slice.new(json)
      "Group" -> Group.new(json)
      "Image" -> ImageMeta.new(json)
      "image" -> Image.new(json)
      "Text" -> Text.new(json)
      "preformatted" -> Preformatted.new(json)
      "embed" -> Embed.new(json)
      "video" -> Video.new(json)
      _ ->
        IO.puts "
=================== #{json["type"]} =================
#{inspect json, pretty: true}
=====================================================
        "
         %{unknown: json["type"], data: json}
    end
  end # end parse_item/1

  def parse_spans(nil) do
    []
  end # end parse_spans/1

  def parse_spans(spans) when is_list(spans) do
    for span <- spans do
      parse_span(span)
    end
  end # end parse_spans/1

  def parse_span(span) do
    case span["type"] do
        "strong" -> Spans.Strong.new(span)
        "em" -> Spans.Em.new(span)
        "hyperlink" -> Spans.HyperLink.new(span)
        _ ->
        IO.puts "
        ================= SPAN: #{inspect span} =============
        #{inspect span, pretty: true}
        =====================================================
        "
        %{unknown_span: span["type"], data: span}
    end
  end # end parse_span/1

end # end defmodule Solace.Prismic.Types.Prismic
