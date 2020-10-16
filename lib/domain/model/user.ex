defmodule SimpleChat.Domain.Model.User do
  @moduledoc false

  alias SimpleChat.Domain.Service.ChatUsers, as: ChatUsersService

  @type t :: %__MODULE__{}

  defstruct login: nil

  @chat_users_servise ChatUsersService

  @spec new(String.t()) :: __MODULE__.t()
  def new(login), do: %__MODULE__{login: login}

  @spec get_chats(__MODULE__.t()) :: []
  def get_chats(%__MODULE__{login: login}), do: @chat_users_servise.get_user_chats(login)
end
