defmodule Ret.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ret.User

  @schema_prefix "ret0"

  schema "users" do
    field :email, :string
    field :auth_provider, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [])
    |> validate_required([])
  end
end
