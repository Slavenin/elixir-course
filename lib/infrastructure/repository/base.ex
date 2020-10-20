defmodule SimpleChat.Infrastructure.Repository.Base do
  @spec result_or_error([{any, any}]) :: {:error, :not_found} | {:ok, any}
  def result_or_error(result) do
    case result do
      [] -> {:error, :not_found}
      [{_, result}] -> {:ok, result}
    end
  end
end
