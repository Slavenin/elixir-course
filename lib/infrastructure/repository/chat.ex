defmodule SimpleChat.Infrastructure.Repository.Chat do
  import SimpleChat.Infrastructure.Repository.Base
  alias SimpleChat.Domain.Model.Chat

  @table chats_table()

  @spec get(String.t()) :: {:error, :not_found} | {:ok, Chat.t()}
  def get(id) do
    :ets.lookup(@table, id)
    |> result_or_error
  end

  @spec add(Chat.t()) :: true
  def add(%Chat{id: id} = chat), do: :ets.insert(@table, {id, chat})

  @spec delete(String.t()) :: true
  def delete(id), do: :ets.delete(@table, id)
end
