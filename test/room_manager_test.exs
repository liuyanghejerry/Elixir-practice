defmodule RoomManagerTest do
  use ExUnit.Case

  test "RoomManager can return correct room list" do
    {:ok, pid} = RoomManager.start
    assert %HashDict{} = RoomManager.get_room_list pid
  end

  test "RoomManager can generate random new room" do
    {:ok, manager_pid} = RoomManager.start
    [pid: _, name: room_name] = RoomManager.new_room manager_pid
    room_pids = RoomManager.get_room_list manager_pid
    assert HashDict.size(room_pids) == 1
    assert HashDict.has_key?(room_pids, room_name)
  end
end
