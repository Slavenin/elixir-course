defmodule SimpleChat.Domain.Model.Chat do
  @moduledoc false

  alias SimpleChat.Domain.Service.ChatUsers, as: ChatUsersService

  @type t :: %__MODULE__{}

  defstruct name: nil, id: nil

  @chat_users_servise ChatUsersService

  @spec new(String.t()) :: __MODULE__.t()
  def new(name), do: %__MODULE__{name: name, id: generate_id()}

  @spec get_users(__MODULE__.t()) :: []
  def get_users(%__MODULE__{id: id}), do: @chat_users_servise.get_users_in_chat(id)

  defp generate_id() do
    datetime =
      NaiveDateTime.local_now()
      |> NaiveDateTime.to_iso8601()

    :crypto.hash(:md5, datetime)
    |> Base.encode16()
  end
end
