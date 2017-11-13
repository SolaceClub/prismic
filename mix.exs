defmodule Prismic.Mixfile do
  use Mix.Project

  def project do
    [app: :prismic,
     version: "0.0.4",
     elixir: "~> 1.4",
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
      {:earmark, "~> 1.2.2", only: :dev},
      {:ex_doc, "~> 0.18.1", only: :dev},
      {:httpoison, "~> 0.13.0"},
      {:poison, "~> 3.1.0"}
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
