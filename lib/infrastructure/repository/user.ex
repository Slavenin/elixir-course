defmodule SimpleChat.Infrastructure.Repository.User do
  import SimpleChat.Infrastructure.Repository.Base
  alias SimpleChat.Domain.Model.User

  @table users_table()

  @spec get(String.t()) :: {:error, atom()} | {:ok, User.t()}
  def get(login) do
    :ets.lookup(@table, login)
    |> result_or_error
  end

  @spec add(User.t()) :: {:error, atom()} | {:ok, true}
  def add(%User{login: login} = user) do
    case get(login) do
      {:ok, _user} ->
        {:error, :exists}

      _ ->
        :ets.insert(@table, {login, user})
        {:ok, true}
    end
  end

  @spec delete(String.t()) :: true
  def delete(login), do: :ets.delete(@table, login)
end
