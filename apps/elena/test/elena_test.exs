defmodule ElenaTest do
  use ExUnit.Case
  doctest Elena

  test "greets the world" do
    assert Elena.hello() == :world
  end
end
