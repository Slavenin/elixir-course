defmodule SimpleChat.Domain.Model.User do
  @moduledoc false

  defstruct login: nil

  @chat_users_servise SimpleChat.Domain.Service.ChatUsers

  def new(login), do: %__MODULE__{login: login}

  def get_chats(%__MODULE__{login: login}), do: @chat_users_servise.get_user_chats(login)
end
