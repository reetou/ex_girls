defmodule Elena.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Elena
    ]

    options = [strategy: :one_for_all, name: Elena.Supervisor]
    Supervisor.start_link(children, options)
  end
end
