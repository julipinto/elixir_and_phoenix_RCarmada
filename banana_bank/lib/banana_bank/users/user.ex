defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @required_fields ~w(name password email cep)a

  @derive {Jason.Encoder, only: [:id, :name, :email, :cep]}
  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :email, :string
    field :cep, :string
    field :password, :string, virtual: true

    timestamps()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> do_validation()
    |> add_password_hash()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields -- [:password])
    |> validate_required(@required_fields -- [:password])
    |> do_validation()
  end

  defp do_validation(changeset) do
    changeset
    |> validate_length(:name, min: 3)
    |> validate_length(:cep, min: 8)
    |> validate_format(:email, ~r/@/)
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, %{password_hash: Argon2.hash_pwd_salt(password)})
  end

  defp add_password_hash(changeset), do: changeset
end
