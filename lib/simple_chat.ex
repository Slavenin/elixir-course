defmodule SimpleChat do
  @moduledoc false

  alias SimpleChat.Domain.Service.Chat, as: ChatService
  alias SimpleChat.Domain.Service.User, as: UserService

  @spec run :: no_return
  def run() do
    loop()
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
