require Room
require SecureRandom

defmodule RoomManager do
  use GenServer
  defstruct room_pids: HashDict.new

  def init(_) do
    {:ok, %RoomManager{}}
  end

  def start() do 
    GenServer.start(RoomManager, nil)
  end

  def get_room_list(pid) do
    GenServer.call(pid, {:room_list})
  end

  def new_room(pid) do
    GenServer.call(pid, {:new_room})
  end
  # Callbacks

  def handle_call({:room_list}, _from, state) do
    %RoomManager{room_pids: room_pids} = state
    {:reply, room_pids, state}
  end

  def handle_call({:new_room}, _from, state) do
    %RoomManager{room_pids: room_pids} = state
    random_name = SecureRandom.hex
    room_params = %Room.RoomParams{name: random_name}
    {:ok, pid} = Room.start(room_params)
    new_room_pids = HashDict.put(room_pids, random_name, pid)
    new_state = %RoomManager{state | :room_pids => new_room_pids}
    {:reply, [pid: pid, name: random_name], new_state}
  end
end
