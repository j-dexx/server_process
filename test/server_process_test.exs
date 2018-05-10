defmodule ServerProcessTest do
  use ExUnit.Case
  doctest ServerProcess

  test "stores values" do
    {:ok, pid} = KeyValueStore.start()
    KeyValueStore.put(pid, :a, 1)
    KeyValueStore.put(pid, :b, 2)
    assert KeyValueStore.get(pid, :a) == 1
    assert KeyValueStore.get(pid, :b) == 2

    Process.exit(pid, :kill)
  end

  test "values not stored returns nil" do
    {:ok, pid} = KeyValueStore.start()

    assert KeyValueStore.get(pid, :c) == nil

    Process.exit(pid, :kill)
  end
end
