defmodule RoomManagerTest do
  use ExUnit.Case

  test "RoomManager can return correct room list" do
    {:ok, pid} = RoomManager.start
    assert %HashDict{} = RoomManager.get_room_list pid
  end

  test "RoomManager can generate random new room" do
    {:ok, manager_pid} = RoomManager.start
    room_pid = RoomManager.new_room
  end
end
