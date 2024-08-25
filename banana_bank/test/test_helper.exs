Mox.defmock(BananaBank.HTTP.ViaCep.ClientMock, for: BananaBank.HTTP.ViaCep.ClientBehaviour)
Application.put_env(:banana_bank, :via_cep_client, BananaBank.HTTP.ViaCep.ClientMock)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BananaBank.Repo, :manual)
