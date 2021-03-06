defmodule Rethinkdb.Mixfile do
  use Mix.Project

  def project do
    [ app: :'rethinkdb',
      version: "0.2.2",
      elixir: "~> 1.0.1",
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Rethinkdb.App, [] },
      applications: [],
      env: Keyword.merge([{:timeout, 30}], env(Mix.env))
    ]
  end

  def env(:test) do
    [rethinkdb_uri: "rethinkdb://localhost:28016/elixir_drive_test"]
  end

  def env(_), do: []

  # Returns the list of dependencies in the format:
  def deps(:prod) do
    [
      { :protobuf, github: "mossplix/elixir-protobuf" },
    ]
  end

  def deps(:test) do
    deps(:prod) ++ [
    #{:meck, github: "eproxus/meck", tag: "0.8.1", override: true},
      {:meck, [branch: "develop" ,github: "eproxus/meck"]},
      {:mock, github: "antp/mock"}
    ]
  end

  def deps(:docs) do
    deps(:prod) ++
      [ { :ex_doc, github: "elixir-lang/ex_doc" } ]
  end

  def deps(_) do
    deps(:prod)
  end
end
