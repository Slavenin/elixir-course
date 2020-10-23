defmodule SimpleChat.Infrastructure.Repository.Base do
  def users_table, do: :users

  def chats_table, do: :chats

  def chat_users_table, do: :chat_users

  def user_chats_table, do: :user_chats

  @spec result_or_error([{any, any}]) :: {:error, :not_found} | {:ok, any}
  def result_or_error(result) do
    case result do
      [] -> {:error, :not_found}
      [{_, result}] -> {:ok, result}
    end
  end
end
