defmodule Vladlena.Connector do
  def connect(node_name) do
    Node.connect(node_name)
    |> case do
      true ->
        connected(node_name)

      false ->
        not_connected(node_name)
        connect(node_name)

      :ignored ->
        IO.inspect("Something bad happened", label: Node.self())
    end
  end

  def connected(node_name) do
    :pong = Node.ping(node_name)
    IO.inspect("Connected to #{node_name} successfully", label: Node.self())
    :connected
  end

  def not_connected(node_name) do
    IO.inspect("Cannot connect to #{node_name}, retrying in 1 sec...", label: Node.self())
    Process.sleep(1000)
  end

  def call_if_connected(module, node_name, fun) when is_function(fun) do
    GenServer.whereis(module)
    |> IO.inspect(label: "Pid for module")
    |> case do
      nil ->
        IO.inspect(module, label: "Cannot find pid for")
        connect(node_name)

      pid when is_pid(pid) ->
        fun.(pid)
    end
  end
end
