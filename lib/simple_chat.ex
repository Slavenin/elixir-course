defmodule SimpleChat do
  @moduledoc false

  import SimpleChat.Infrastructure.Repository.Base,
    only: [chat_users_table: 0, chats_table: 0, user_chats_table: 0, users_table: 0]

  alias SimpleChat.Domain.Service.Message, as: MessageService

  @tables [
    chat_users_table(),
    chats_table(),
    user_chats_table(),
    users_table()
  ]

  @spec run :: no_return
  def run() do
    Enum.each(@tables, &init_table/1)

    spawn_link(__MODULE__, :loop, [])
  end

  @spec loop :: no_return
  def loop() do
    receive do
      msg -> MessageService.handle_message(msg)
    end

    loop()
  end

  defp init_table(name) do
    :ets.new(name, [:public, :named_table, :set])
  end
end
