defmodule ExAws.Rekognition.MixProject do
  use Mix.Project

  @version "0.5.0"
  @service "rekognition"
  @url "https://github.com/coletiv/ex_aws_#{@service}"
  @name __MODULE__ |> Module.split() |> Enum.take(2) |> Enum.join(".")

  def project do
    [
      app: :ex_aws_rekognition,
      version: @version,
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: @name,
      package: package(),
      docs: [main: @name, source_ref: "v#{@version}", source_url: @url]
    ]
  end

  defp package do
    [
      description: "#{@name} service package",
      files: ["lib", "config", "mix.exs", "README*"],
      maintainers: ["André Silva"],
      licenses: ["MIT"],
      links: %{github: @url}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:hackney, ">= 0.0.0", only: [:dev, :test]},
      {:sweet_xml, ">= 0.0.0", only: [:dev, :test]},
      {:poison, ">= 0.0.0", only: [:dev, :test]},
      {:ex_doc, ">= 0.0.0", only: [:dev]},
      ex_aws()
    ]
  end

  defp ex_aws() do
    case System.get_env("AWS") do
      "LOCAL" -> {:ex_aws, path: "../ex_aws"}
      _ -> {:ex_aws, "~> 2.0"}
    end
  end
end
