defmodule App.Release do
  @moduledoc """
  Release tasks for production use.

  Runs database migrations without starting the full application.
  Invoked from zerops.yaml initCommands:

      ./bin/app eval "App.Release.migrate()"
  """

  @app :app

  def migrate do
    load_app()

    for repo <- repos() do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  defp load_app do
    Application.load(@app)
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end
end
