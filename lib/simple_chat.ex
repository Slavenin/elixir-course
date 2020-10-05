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
    IO.inspect("Hello #{name}")
  end

  def hello(%{"name" => name, "age" => age}) do
    hello("#{name} #{age}")
  end

  # users = [%{"age" => 10, "name" => "a"}, %{"age" => 12, "name" => "b"}, %{"age" => 15, "name" => "v"}, %{"age" => 14, "name" => "c"}]
  def hello(users) when is_list(users) do
    Enum.sort(users, fn
      %{"age" => age1}, %{"age" => age2} when age1 > age2 -> false
      %{"age" => age1}, %{"age" => age2} when age1 < age2 -> true
      %{"age" => age1}, %{"age" => age2} when age1 == age2 -> true
    end)
    |> Enum.each(fn user -> hello(user) end)
  end

  def hello(_), do: :error
end
