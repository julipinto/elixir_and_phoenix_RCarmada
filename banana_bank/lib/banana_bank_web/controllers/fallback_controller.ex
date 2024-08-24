defmodule BananaBankWeb.FallbackController do
  use BananaBankWeb, :controller

  def call(conn, {:error, changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: BananaBankWeb.ErrorJSON)
    |> render(:bad_request, changeset: changeset)
  end
end