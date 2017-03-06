#-------------------------------------------------------------------------------
# Author: Keith Brings <keith.brings@noizu.com>
# Copyright (C) 2016 Solace Club, LLC. All rights reserved.
#-------------------------------------------------------------------------------

defmodule Solace.Prismic.Api do
  @moduledoc """
    @TODO move into own repo.
  """
  alias Solace.Prismic.Api
  alias Solace.Prismic.Predicate
  @vsn(0.01)
  @default_retries(3)

  @type t :: %Api{
    project: String.t,
    ref: String.t,
    access_token: String.t|nil,
    predicates: nil|[],
    sort: nil|[],
    config: Solace.Prismic.Api.Config.t,
    retries: integer,
    vsn: float
  }

  defstruct [
    project: nil,
    ref: nil,
    access_token: nil,
    predicates: nil,
    sort: nil,
    config: nil,
    retries: @default_retries,
    vsn: @vsn
  ]

  @doc """
    TODO implement transaction style logic for fetching release details,
    Api.action do

    end

    Api.action(credentials) do

    end
  """
  def new() do
    %Api{project: Application.get_env(:prismic, :project)}
      |> loadConfig()
  end # end new/0

  def loadConfig(%Api{} = api) do
    url = "https://#{api.project}.prismic.io/api"
      |> URI.encode
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        config = body
          |> Poison.decode!()
          |> Solace.Prismic.Api.Config.new()

        if api.ref == nil do
          ref = Solace.Prismic.Api.Config.ref(config, :master)
          %Api{api| config: config, ref: ref}
        else
          %Api{api| config: config}
        end

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, %HTTPoison.Error{reason: reason}}
    end
  end # end loadConfig/1

  def getById(%Api{} = api, id) do
    r = api
      |> add(Predicate.at("document.id", id))
      |> query()

      if (r.results_size > 0) do
        [h|_t] = r.results
        h
      else
        :nil
      end
  end # end getById/2

  def getByUid(%Api{} = api, type, id) do
    r = api
      |> add(Predicate.at("my.#{type}.uid", id))
      |> query()

    if (r.results_size > 0) do
      [h|_t] = r.results
      h
    else
      :nil
    end
  end # end getByUid/3

  def getByType(%Api{} = api, type) do
    api
      |> add(Predicate.at("document.type", type))
      |> query()
  end # end getByType/2

  def add(%Api{predicates: nil} = api, %Predicate{} = predicate) do
      %Api{api| predicates: [predicate]}
  end # end add/2

  def add(%Api{predicates: predicates} = api, %Predicate{} = predicate) when is_list(predicates) do
    %Api{api| predicates: predicates ++ [predicate]}
  end # end add/2

  def add(%Api{} = api, entries) when is_list(entries) do
    List.foldl(
      entries,
      api,
      fn(x, acc) ->
        add(acc, x)
      end
    )
  end # end add/2

  def request_part(%Api{} = api, :auth) do
    case api.access_token do
      nil -> nil
      token -> "access_token=#{token}"
    end
  end # end request_part/2

  def request_part(%Api{} = _api, :order) do
    nil
  end # end request_part/2

  def request_part(%Api{} = api, :query) do
    case api.predicates do
      nil -> ""
      [] -> ""
      predicates when is_list(predicates) ->
        ps =
          (for predicate <- predicates do
            Solace.Prismic.UrlEncodeProtocol.encode(predicate)
          end)
          |> join
        "q=[" <> ps <> "]"
    end
  end # end request_part/2

  def request_part(%Api{} = api, :ref) do
    "ref=#{api.ref}"
  end # end request_part/2

  def join([h|t], seperator \\ ",") do
    h <> List.foldl(t, "",
      fn(x, acc) ->
        acc <> seperator <> x
      end
    )
  end # end join/2

  def query(api, retries \\ :default)

  def query(%Api{} = api, :default) do
    case api.retries do
      :default -> query(api, @default_retries)
      n -> query(api, n)
    end
  end

  def query(%Api{} = api, retries) do
    param_string =
      [request_part(api, :auth), request_part(api, :query), request_part(api, :order), request_part(api, :ref)]
      |> Enum.filter(fn(x) -> x != nil end)
      |> join("&")

    url = "https://#{api.project}.prismic.io/api/documents/search?#{param_string}"
      |> URI.encode

    #IO.puts "calling: #{url}"
    case HTTPoison.get(url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
          |> Poison.decode!()
          |> Solace.Prismic.Response.new(api.ref)
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        if (retries > 0), do: query(api, retries - 1), else: {:error, :not_found}

      {:error, %HTTPoison.Error{reason: reason}} ->
        if (retries > 0), do: query(api, retries - 1), else: {:error, %HTTPoison.Error{reason: reason}}
    end
  end # end query/1

end # end defmodule Solace.Prismic.Api
