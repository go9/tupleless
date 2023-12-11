defmodule Tupleless.MixProject do
  use Mix.Project

  def project do
    [
      app: :tupleless,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def package() do
    [
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Giovanni Orlando"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/go9/tupleless"}
    ]
  end

  def description() do
    "Introduces concept of delinating tupleless functions and provides support for wrapping tupleless return values."
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
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
