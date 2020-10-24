defmodule SimpleChat.Domain.Service.Message do
  require Logger
  def send_message_to_user(message, chat, user_from, user_to) do
    Logger.debug(
      "message from user #{user_from.login}\nin chat #{chat.name}\nneed update chat for user #{
        user_to
      }\n text:\n#{message}"
    )
  end
end
