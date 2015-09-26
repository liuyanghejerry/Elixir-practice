defmodule Room do
  use GenServer
  defstruct name: "", max_load: 8, current_load: 0, pass_hash: ""

  defmodule RoomParams do
    defstruct name: "", welcome_message: "", max_load: 8, pass_hash: ""
  end

  def init(%RoomParams{} = params) do
    {:ok, %Room{
      name: params.name, 
      max_load: params.max_load, 
      current_load: 0, 
      pass_hash: params.pass_hash
      }
    }
  end

  def start(%RoomParams{} = params) do 
    GenServer.start(Room, params)
  end

  def get_current_load(pid) do
    GenServer.call(pid, {:current_load})
  end
  # Callbacks

  def handle_call({:current_load}, _from, state) do
    %Room{current_load: current_load} = state
    {:reply, current_load, state}
  end
end
