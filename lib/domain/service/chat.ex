defmodule SimpleChat.Domain.Service.Chat do
  alias SimpleChat.Domain.Model.Chat, as: ChatModel
  alias SimpleChat.Infrastructure.Repository.Chat, as: ChatrRepo

  @spec add(binary()) :: true
  def add(name) do
    name
    |> ChatModel.new()
    |> ChatrRepo.add()
  end

  @spec delete(ChatModel.t()) :: true
  def delete(%ChatModel{id: id}), do: ChatrRepo.delete(id)
end
