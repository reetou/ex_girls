defmodule Vladlena do
  use GenServer
  import Vladlena.Connector

  @elena_node_name String.to_atom("elena@MacBook-Pro-Vladimir-3")

  def start_link(state) do
    {:ok, pid} = GenServer.start_link(__MODULE__, state, id: {:global, __MODULE__})
    connect(@elena_node_name)
    {:ok, pid}
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  def send_transactions() do
    call_if_connected({:global, Elena}, @elena_node_name, fn pid ->
      IO.inspect(pid, label: "PID AT CALL IF CONNECTED CALLBACK")

      1..100
      |> Enum.each(fn i ->
        {:ok, _data} = GenServer.call(pid, {:transaction, "Steam_#{i}"})
      end)
      |> IO.inspect(label: "Sent some transactions")
    end)
  end
end
