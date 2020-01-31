defmodule Elena do
  use GenServer
  import Vladlena.Connector

  @lyuda_node_name String.to_atom("lyuda@MacBook-Pro-Vladimir-3")

  def start_link(state) do
    {:ok, pid} = GenServer.start_link(__MODULE__, state, name: {:global, __MODULE__})
    :connected = connect(@lyuda_node_name)
    {:ok, pid}
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  def handle_call({:transaction, pos_terminal}, _from, state) do
    IO.inspect(pos_terminal, label: "Transaction with pos_terminal arrived")

    call_if_connected({:global, Lyuda}, @lyuda_node_name, fn pid ->
      IO.inspect(pid, label: "Pid in elena")
      :ok = GenServer.cast(pid, {:transaction_log, pos_terminal})
    end)
    |> IO.inspect(label: "Send result")

    {:reply, {:ok, pos_terminal}, state}
  end

  def handle_info(msg, state) do
    IO.inspect(msg, label: "Message received in elena at handle info")
    {:noreply, state}
  end
end
