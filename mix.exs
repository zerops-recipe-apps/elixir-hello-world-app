defmodule App.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/zerops-recipe-apps/elixir-hello-world-app"

  def project do
    [
      app: :app,
      version: @version,
      elixir: "~> 1.16",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        app: [
          include_executables_for: [:unix]
        ]
      ],
      description: "Minimal Elixir Plug/Bandit + Ecto hello-world recipe for Zerops",
      package: [
        licenses: ["MIT"],
        links: %{"GitHub" => @source_url}
      ],
      source_url: @source_url
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {App.Application, []}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      {:plug, "~> 1.20.3"},
      {:bandit, "~> 1.12.4"},
      {:jason, "~> 1.4"},
      {:ecto_sql, "~> 3.13"},
      {:postgrex, "~> 0.22"}
    ]
  end
end
