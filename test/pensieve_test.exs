defmodule PensieveTest do
  use ExUnit.Case
  doctest Pensieve

  test "greets the world" do
    assert Pensieve.hello() == :world
  end
end
