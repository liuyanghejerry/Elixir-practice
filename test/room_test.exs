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

  test "Room can return correct basic info" do
    params = %Room.RoomParams{
      name: "test_name", 
      max_load: 16,
      pass_hash: "hash content",
      welcome_message: "welcome to my room!",
    }
    assert {:ok, pid} = Room.start params
    %Room.RoomBasicInfo{
      current_load: current_load,
      is_private: is_private,
      welcome_message: welcome_message,
    } = Room.get_basic_info pid
    assert is_private == true
    assert current_load == 0
    assert byte_size(welcome_message) > 0
  end
end
