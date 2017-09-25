defmodule Microblog.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :username, :string
      add :email, :string
      add :verified, :boolean, default: false, null: false
      add :followers, :integer
      add :following, :integer
      add :posts, :integer
      add :description, :text

      timestamps()
    end

  end
end
