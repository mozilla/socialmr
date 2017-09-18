defmodule Ret.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, schema: "ret0", primary_key: false) do
      add :user_id, :bigint, default: fragment("ret0.next_id()"), primary_key: true
      add :email, :string, null: false
      add :auth_provider, :string, null: false

      timestamps()
    end

    create index(:users, [:email, :auth_provider], unique: true)
  end
end
