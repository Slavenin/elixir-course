defmodule SimpleChat do
  @moduledoc """
  Documentation for `SimpleChat`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> SimpleChat.hello()
      :world

  """
  def hello do
    :world
  end

  def hello(name) when is_binary(name) do
    "hello #{name}"
  end

  def hello(%{"name" => name, "age" => age}) do
    hello("#{name} #{age}")
  end

  def hello(users) when is_list(users) do
    Enum.each(users, fn user -> hello(user) end)
  end

  def hello(_), do: :error
end
