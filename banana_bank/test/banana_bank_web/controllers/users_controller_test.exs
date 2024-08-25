defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase

  alias BananaBank.Users
  alias Users.User

  describe "create/2" do
    test "creates a user", %{conn: conn} do
      params = %{name: "John Doe", email: "john@example", cep: "12345678", password: "123456"}

      response =
        conn
        |> post("/api/users", params)
        |> json_response(:created)

      assert %{
               "data" => %{
                 "id" => _id,
                 "cep" => "12345678",
                 "email" => "john@example",
                 "name" => "John Doe"
               },
               "message" => "User created successfully"
             } = response
    end

    test "returns an error when the params are invalid", %{conn: conn} do
      params = %{name: "John Doe", email: "john@example", cep: "1234567"}

      response =
        conn
        |> post("/api/users", params)
        |> json_response(:bad_request)

      assert %{
               "errors" => %{
                 "password" => ["can't be blank"],
                 "cep" => ["should be at least 8 character(s)"]
               }
             } = response
    end
  end

  describe "delete/2" do
    test "deletes a user", %{conn: conn} do
      {:ok, %User{} = user} = Users.create(%{name: "John Doe", email: "john@example", cep: "12345678", password: "123456"})

      response =
        conn
        |> delete("/api/users/#{user.id}")
        |> json_response(:ok)

      assert %{"message" => "User deleted successfully"} = response
    end

    test "returns an error when the user does not exist", %{conn: conn} do
      response =
        conn
        |> delete("/api/users/1")
        |> json_response(:not_found)

      assert %{"message" => "Resource not found"} = response
    end
  end

  describe "show/2" do
    test "returns a user", %{conn: conn} do
      {:ok, %User{} = user} = Users.create(%{name: "John Doe", email: "john@example", cep: "12345678", password: "123456"})

      response =
        conn
        |> get("/api/users/#{user.id}")
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "id" => _id,
                 "cep" => "12345678",
                 "email" => "john@example",
                 "name" => "John Doe"
               }
             } = response
    end

    test "returns an error when the user does not exist", %{conn: conn} do
      response =
        conn
        |> get("/api/users/1")
        |> json_response(:not_found)

      assert %{"message" => "Resource not found"} = response
    end
  end

  describe "update/3" do
    test "updates a user", %{conn: conn} do
      {:ok, %User{} = user} = Users.create(%{name: "John Doe", email: "john@example", cep: "12345678", password: "123456"})

      params = %{name: "Jane Doe", email: "jane@example", cep: "87654321", password: "654321"}

      response =
        conn
        |> put("/api/users/#{user.id}", params)
        |> json_response(:ok)

      assert %{
               "data" => %{
                 "id" => _id,
                 "cep" => "87654321",
                 "email" => "jane@example",
                 "name" => "Jane Doe"
               },
               "message" => "User updated successfully"
             } = response
    end

    test "returns an error when the user does not exist", %{conn: conn} do
      response =
        conn
        |> put("/api/users/1", %{name: "Jane Doe", email: "jane@example", cep: "87654321", password: "654321"})
        |> json_response(:not_found)

      assert %{"message" => "Resource not found"} = response
    end

    test "returns an error when the params are invalid", %{conn: conn} do
      {:ok, %User{} = user} = Users.create(%{name: "John Doe", email: "john@example", cep: "12345678", password: "123456"})

      response =
        conn
        |> put("/api/users/#{user.id}", %{name: "Jane Doe", email: "jane@example", cep: "1234567"})
        |> json_response(:bad_request)

      assert %{
               "errors" => %{
                 "cep" => ["should be at least 8 character(s)"]
               }
             } = response
    end
  end
end
