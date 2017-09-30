defmodule Microblog.Repo.Migrations.EditUsers do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :verified
      remove :followers
      remove :following
      remove :posts
      remove :description
    end
  end
end
