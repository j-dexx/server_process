defmodule KeyValueStore do
  use GenServer

  def start do
    GenServer.start(KeyValueStore, nil)
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def init(_) do
    :timer.send_interval(5000, :cleanup) # Sends a message to the caller process - not GenServer specific so GenServer calls handle_info
    {:ok, %{}}
  end

  def handle_call({:get, key}, _, state) do
    {:reply, Map.get(state, key), state}
  end

  def handle_cast({:put, key, value},  state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_info(:cleanup, state) do
    IO.puts "performing cleanup..."
    {:noreply, state}
  end

  def handle_info(unknown_message, state) do
    super(unknown_message, state)
  end
end
