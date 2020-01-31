defmodule LyudaTest do
  use ExUnit.Case
  doctest Lyuda

  test "greets the world" do
    assert Lyuda.hello() == :world
  end
end
