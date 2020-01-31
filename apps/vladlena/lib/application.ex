defmodule Vladlena.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Vladlena
    ]

    options = [strategy: :one_for_all, name: Vladlena.Supervisor]
    Supervisor.start_link(children, options)
  end
end
