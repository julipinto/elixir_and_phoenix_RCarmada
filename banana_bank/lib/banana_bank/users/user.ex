defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset

  @fields ~w(name password password_hash email cep)a

  schema "users" do
    field :name, :string
    field :password_hash, :string
    field :email, :string
    field :cep, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user \\ %__MODULE__{}, attrs) do
    user
    |> cast(attrs, @fields -- [:password_hash])
    |> validate_required(@fields -- [:password_hash])
    |> validate_length(:name, min: 3)
    |> validate_length(:cep, min: 8)
    |> validate_format(:email, ~r/@/)
    |> add_password_hash()
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, %{password_hash: Argon2.hash_pwd_salt(password)})
  end

  defp add_password_hash(changeset), do: changeset
end
