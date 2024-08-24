defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User created successfully",
      data: user
    }
  end

  def get(%{user: user}), do: %{data: user}
end