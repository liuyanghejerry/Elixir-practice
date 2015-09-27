defmodule Room do
  use GenServer
  defstruct name: "", max_load: 8, current_load: 0, pass_hash: "", welcome_message: ""

  defmodule RoomParams do
    defstruct name: "", welcome_message: "", max_load: 8, pass_hash: ""
  end

  defmodule RoomBasicInfo do
    defstruct name: "", welcome_message: "", current_load: 0, max_load: 8, is_private: false
  end

  def init(%RoomParams{} = params) do
    {:ok, %Room{
      name: params.name, 
      max_load: params.max_load, 
      current_load: 0, 
      pass_hash: params.pass_hash,
      welcome_message: params.welcome_message
      }
    }
  end

  def start(%RoomParams{} = params) do 
    GenServer.start(Room, params)
  end

  def get_current_load(pid) do
    GenServer.call(pid, {:current_load})
  end

  def get_basic_info(pid) do
    GenServer.call(pid, {:basic_info})
  end
  # Callbacks

  def handle_call({:current_load}, _from, state) do
    %Room{current_load: current_load} = state
    {:reply, current_load, state}
  end

  def handle_call({:basic_info}, _from, %Room{
      name: name,
      current_load: current_load,
      max_load: max_load,
      pass_hash: pass_hash,
      welcome_message: welcome_message
    } = state) do
    basic_info = %RoomBasicInfo{
      name: name,
      current_load: current_load,
      max_load: max_load,
      is_private: byte_size(pass_hash) > 0,
      welcome_message: welcome_message,
    }
    {:reply, basic_info, state}
  end
end
