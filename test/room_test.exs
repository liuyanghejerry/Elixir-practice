defmodule RoomTest do
  use ExUnit.Case

  test "Room can return correct current_load" do
    params = %Room.RoomParams{
      name: "test_name", 
      max_load: 16,
      pass_hash: ""
    }
    assert {:ok, pid} = Room.start params
    assert 0 == Room.get_current_load pid
  end
end
