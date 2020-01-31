defmodule Lyuda do
  use GenServer

  def start_link(state) do
    {:ok, _pid} =
      GenServer.start_link(__MODULE__, state, name: {:global, __MODULE__})
      |> IO.inspect(label: "Lyuda successfully started")
  end

  @impl true
  def init(state) when is_list(state) do
    {:ok, state}
  end

  def handle_cast({:transaction_log, pos_terminal}, state) do
    state =
      (state ++ [pos_terminal])
      |> IO.inspect(label: "Transaction with pos terminal #{pos_terminal} happened, log now is")

    {:noreply, state}
  end
end
