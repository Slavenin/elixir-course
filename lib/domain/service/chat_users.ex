defmodule SimpleChat.Domain.Service.ChatUsers do
  alias SimpleChat.Infrastructure.Repository, as: Repo
  alias SimpleChat.Domain.Model.{User, Chat}
  alias SimpleChat.Infrastructure.Repository.Chat, as: ChatRepo
  alias SimpleChat.Infrastructure.Repository.User, as: UserRepo

  @spec get_user_chats(binary) :: {:error, :not_found} | {:ok, [Chat.t(), ...]}
  def get_user_chats(login) do
    Repo.UserChats.get(login)
  end

  @spec get_users_in_chat(binary) ::
          {:error, :not_found} | {:ok, [User.t(), ...]}
  def get_users_in_chat(chat_id) do
    Repo.ChatUsers.get(chat_id)
  end

  @spec add_user_to_chat(binary(), binary()) :: :ok | {:error, :not_found}
  def add_user_to_chat(user_login, chat_id) do
    with {:ok, _chat} <- ChatRepo.get(chat_id),
         {:ok, user} <- UserRepo.get(user_login) do
      Repo.ChatUsers.add_user(user, chat_id)
      Repo.UserChats.add_chat(user, chat_id)
    end
  end

  @spec remove_user_from_chat(User.t(), binary) :: true
  def remove_user_from_chat(user, chat_id) do
    Repo.ChatUsers.remove_user(user, chat_id)
    Repo.UserChats.remove_chat(user, chat_id)
  end
end
