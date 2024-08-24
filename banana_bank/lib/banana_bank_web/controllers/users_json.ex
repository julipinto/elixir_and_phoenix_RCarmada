defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User created successfully",
      data: data(user)
    }
  end	

  defp data(%User{} = user) do
    %{
      id: user.id,
      cep: user.cep,
      name: user.name,
      email: user.email
    }
  end
end