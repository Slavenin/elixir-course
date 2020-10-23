defmodule SimpleChat.Domain.Model.Chat do
  @moduledoc false

  alias SimpleChat.Domain.Service.ChatUsers, as: ChatUsersService
  alias SimpleChat.Domain.Model.User

  @type t :: %__MODULE__{}

  defstruct name: nil, id: nil

  @chat_users_servise ChatUsersService

  @spec new(String.t()) :: __MODULE__.t()
  def new(name), do: %__MODULE__{name: name, id: generate_id()}

  @spec get_users(__MODULE__.t()) :: []
  def get_users(%__MODULE__{id: id}), do: @chat_users_servise.get_users_in_chat(id)

  @spec join_chat(User.t(), binary()) :: {:ok, true} | {:error, binary()}
  def join_chat(%User{} = user, chat_id), do: @chat_users_servise.add_user_to_chat(user, chat_id)

  @spec leave_chat(User.t(), binary()) :: {:ok, true} | {:error, binary()}
  def leave_chat(%User{} = user, chat_id),  do: @chat_users_servise.remove_user_from_chat(user)

  defp generate_id() do
    datetime =
      NaiveDateTime.local_now()
      |> NaiveDateTime.to_iso8601()

    :crypto.hash(:md5, datetime)
    |> Base.encode16()
  end
end
