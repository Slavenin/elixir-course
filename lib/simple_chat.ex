defmodule SimpleChat do
  @moduledoc false

  import SimpleChat.Infrastructure.Repository.Base,
    only: [chat_users_table: 0, chats_table: 0, user_chats_table: 0, users_table: 0]

  alias SimpleChat.Domain.Service.Chat, as: ChatService
  alias SimpleChat.Domain.Service.User, as: UserService

  @spec run :: no_return
  def run() do
    :ets.new(chats_table(), [:public, :named_table, :set])
    :ets.new(users_table(), [:public, :named_table, :set])
    :ets.new(chat_users_table(), [:public, :named_table, :set])
    :ets.new(user_chats_table(), [:public, :named_table, :set])

    spawn_link(__MODULE__, :loop, [])
  end

  @spec loop :: no_return
  def loop() do
    receive do
      {:new_chat, name} ->
        ChatService.add(name)

      {:new_user, login} ->
        UserService.add(login)
    end

    loop()
  end
end
