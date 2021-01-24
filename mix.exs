defmodule Pensieve.MixProject do
  use Mix.Project

  def project do
    [
      app: :pensieve,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      package: package(),
      deps: deps(),
      description: description(),
      source_url: "https://github.com/automatico/pensieve"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "Backup network device configs."
  end

  defp deps do
    [
      {:sshex, "~> 2.1"},

      # Docs
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:earmark, "~> 1.4", only: :dev, runtime: false}
    ]
  end

  defp package() do
    [
      # These are the default files included in the package
      files: ~w(lib .formatter.exs mix.exs README*
                LICENSE* CHANGELOG*),
      licenses: ["GNU General Public License v3.0"],
      links: %{"GitHub" => "https://github.com/automatico/pensieve"}
    ]
  end


end
