defmodule BananaBankWeb.UsersController do
  use BananaBankWeb, :controller

  alias BananaBank.Users
  alias Users.User

  action_fallback BananaBankWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Users.create(params) do
      conn
      |> put_status(:created)
      |> render(:create, user: user)
    end
  end

  # defp handle_response({:ok, user}, conn) do
  #   conn
  #   |> put_status(:created)
  #   |> render(:create, user: user)
  # end

  # defp handle_response({:error, changeset} = error, conn) do
  #   conn
  #   |> put_status(:bad_request)
  #   |> put_view(json: BananaBankWeb.ErrorJSON)
  #   |> render(:bad_request, changeset: changeset)
  # end
end