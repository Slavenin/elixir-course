defmodule SimpleChat.Domain.Service.User do
  alias SimpleChat.Domain.Model.User, as: UserModel
  alias SimpleChat.Infrastructure.Repository.User, as: UserRepo

  @spec add(binary) :: {:error, :exists} | {:ok, true}
  def add(name) do
    name
    |> UserModel.new()
    |> UserRepo.add()
  end

  @spec delete(UserModel.t()) :: true
  def delete(%UserModel{login: login}), do: UserRepo.delete(login)
end
