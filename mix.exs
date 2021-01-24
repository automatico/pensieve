defmodule Pensieve.MixProject do
  use Mix.Project

  def project do
    [
      app: :pensieve,
      version: "2021.01.01",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:sshex, "~> 2.1"},
      {:ex_doc, "~> 0.23"},
      {:earmark, "~> 1.4"}
    ]
  end
end
