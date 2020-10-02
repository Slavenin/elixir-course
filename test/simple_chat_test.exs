defmodule SimpleChatTest do
  use ExUnit.Case
  doctest SimpleChat

  test "greets the world" do
    assert SimpleChat.hello() == :world
  end
end
