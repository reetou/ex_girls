defmodule Lyuda.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Lyuda
    ]

    options = [strategy: :one_for_all, name: Lyuda.Supervisor]
    Supervisor.start_link(children, options)
  end
end
