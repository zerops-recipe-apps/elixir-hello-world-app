defmodule App.Application do
  use Application

  @impl true
  def start(_type, _args) do
    port = Application.get_env(:app, :port, 4000)

    children = [
      App.Repo,
      {Bandit, plug: App.Router, scheme: :http, port: port, ip: {0, 0, 0, 0}}
    ]

    opts = [strategy: :one_for_one, name: App.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
