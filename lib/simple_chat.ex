defmodule SimpleChat do
  @moduledoc false

  import SimpleChat.Infrastructure.Repository.Base,
    only: [chat_users_table: 0, chats_table: 0, user_chats_table: 0, users_table: 0]

  alias SimpleChat.Domain.Service.Chat, as: ChatService
  alias SimpleChat.Domain.Service.User, as: UserService
  alias SimpleChat.Domain.Model.Chat, as: ChatModel

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
      {:new_chat, name} ->
        ChatService.add(name)

      {:new_user, login} ->
        UserService.add(login)

      {:send_message_to_chat, mesasge, chat_id, user_login} ->
        ChatService.send_message_to_users(mesasge, chat_id, user_login)

      {:join_chat, user_login, chat_id} ->
        ChatModel.join_chat(user_login, chat_id)

      {:leave_chat, user_login, chat_id} ->
        ChatModel.leave_chat(user_login, chat_id)
    end

    loop()
  end

  defp init_table(name) do
    :ets.new(name, [:public, :named_table, :set])
  end
end
