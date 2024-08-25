defmodule BananaBank.Users.Create do
  alias BananaBank.Repo
  alias BananaBank.Users.User
  alias BananaBank.HTTP.ViaCep.Client, as: ViaCepClient

  def call(%{"cep" => cep} = attrs) do
    with {:ok, _result} <- client().call(cep) do
      attrs
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp client do
    Application.get_env(:banana_bank, :via_cep_client, ViaCepClient)
  end
end
