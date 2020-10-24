# SimpleChat

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `simple_chat` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:simple_chat, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/simple_chat](https://hexdocs.pm/simple_chat).

pid = SimpleChat.run()
send(pid, {:new_user, "test"})
send(pid, {:new_chat, "test_chat"})
send(pid, {:join_chat, "test", :ets.first(:chats)})
send(pid, {:send_message_to_chat, "test message", :ets.first(:chats), "test"})