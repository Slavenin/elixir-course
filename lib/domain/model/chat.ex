defmodule SimpleChat.Domain.Model.Chat do
  @moduledoc false

  defstruct name: nil, users: []

  def new(name), do: %__MODULE__{name: name}
end
