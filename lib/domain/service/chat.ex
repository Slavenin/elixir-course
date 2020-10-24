defmodule SimpleChat.Domain.Service.Chat do
  alias SimpleChat.Domain.Model.Chat, as: ChatModel
  alias SimpleChat.Infrastructure.Repository.Chat, as: ChatRepo
  alias SimpleChat.Infrastructure.Repository.User, as: UserRepo
  alias SimpleChat.Infrastructure.Repository.ChatUsers, as: ChatUsersRepo
  alias SimpleChat.Domain.Service.Message, as: MessageService

  @spec add(binary()) :: true
  def add(name) do
    name
    |> ChatModel.new()
    |> ChatRepo.add()
  end

  @spec delete(ChatModel.t()) :: true
  def delete(%ChatModel{id: id}), do: ChatRepo.delete(id)

  def send_message_to_users(message, chat_id, user_login) do
    with {:ok, chat} <- ChatRepo.get(chat_id),
         {:ok, user_from} <- UserRepo.get(user_login),
         {:ok, users} <- ChatUsersRepo.get(chat_id) do
      Enum.each(users, fn user_to ->
        MessageService.send_message_to_user(message, chat, user_from, user_to)
      end)
    end
  end
end
