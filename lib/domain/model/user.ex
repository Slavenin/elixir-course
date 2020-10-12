defmodule SimpleChat.Domain.Model.User do
  @moduledoc false

  defstruct login: nil, rooms: []

  def new(login), do: %__MODULE__{login: login}
end
