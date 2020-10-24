defmodule SimpleChat.Domain.Service.Message do
  require Logger

  alias SimpleChat.Domain.Service.Chat, as: ChatService
  alias SimpleChat.Domain.Service.User, as: UserService
  alias SimpleChat.Domain.Model.Chat, as: ChatModel
  alias SimpleChat.Domain.Model.User, as: UserModel

  @spec handle_message(any) :: :ok | true | {:error, :exists | :not_found} | {:ok, true}
  def handle_message({:new_chat, name}) do
    ChatService.add(name)
  end

  def handle_message({:new_user, login}) do
    UserService.add(login)
  end

  def handle_message({:send_message_to_chat, mesasge, chat_id, user_login}) do
    ChatService.send_message_to_users(mesasge, chat_id, user_login)
  end

  def handle_message({:join_chat, user_login, chat_id}) do
    ChatModel.join_chat(user_login, chat_id)
  end

  def handle_message({:leave_chat, user_login, chat_id}) do
    ChatModel.leave_chat(user_login, chat_id)
  end

  def handle_message(msg) do
    Logger.error("unexpected message #{inspect(msg)}")
  end

  @spec send_message_to_user(binary(), ChatModel.t(), UserModel.t(), binary()) :: :ok
  def send_message_to_user(message, chat, user_from, user_to) do
    Logger.debug(
      "message from user #{user_from.login}\nin chat #{chat.name}\nneed update chat for user #{
        user_to
      }\n text:\n#{message}"
    )
  end
end
