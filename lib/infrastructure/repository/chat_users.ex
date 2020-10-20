defmodule SimpleChat.Infrastructure.Repository.ChatUsers do
  @table :chat_users

  import SimpleChat.Infrastructure.Repository.Base
  alias SimpleChat.Domain.Model.User
  alias SimpleChat.Infrastructure.Repository.Chat

  @spec add_user(binary(), User.t()) :: :ok | {:error, :not_found}
  def add_user(chat_id, %User{} = user) do
    with {:ok, _chat} <- Chat.get(chat_id),
         true <-
           :ets.lookup(@table, chat_id)
           |> add_user_to_chat(chat_id, user) do
      :ok
    end
  end

  @spec remove_user(binary(), User.t()) :: true
  def remove_user(chat_id, %User{login: login}) do
    case get(chat_id) do
      {:ok, users} ->
        new_users =
          Enum.filter(users, fn
            %User{login: ^login} -> false
            _ -> true
          end)

        :ets.insert(@table, {chat_id, new_users})
    end
  end

  @spec get(binary()) :: {:error, :not_found} | {:ok, [User.t(), ...]}
  def get(chat_id) do
    :ets.lookup(@table, chat_id) |> result_or_error()
  end

  defp add_user_to_chat([], chat_id, user) do
    :ets.insert(@table, {chat_id, [user]})
  end

  defp add_user_to_chat([{_, users}], chat_id, user) do
    :ets.insert(@table, {chat_id, [user | users]})
  end
end
