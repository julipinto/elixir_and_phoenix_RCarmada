defmodule BananaBank.Users.Create do
  alias BananaBank.Repo
  alias BananaBank.Users.User

  def call(attrs) do
    attrs
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end