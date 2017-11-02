defmodule Prismic.Mixfile do
  use Mix.Project

  def project do
    [app: :prismic,
     version: "0.0.3",
     elixir: "~> 1.2",
     package: package(),
     description: description(),
     source_url: project_url(),
     homepage_url: project_url(),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [
      applications: [
        :logger,
        :httpoison
      ]
    ]
  end

  defp deps do
    [
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:httpoison, "~> 0.13.0"},
      {:poison, "~> 2.2.0"}
    ]
  end

  defp description do
    """
    Basic Prismic API support.
    """
  end

  defp project_url do
    """
    https://github.com/SolaceClub/prismic
    """
  end

  defp package do
    [
      files: ["lib", "mix.exs", "LICENSE", "README.md"],
      maintainers: ["Alex Garibay"],
      licenses: ["MIT"],
      links: %{"GitHub" => project_url}
    ]
  end

end
