defmodule Microblog.Repo.Migrations.AddProfileDescription do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :description, :text
    end
  end

end
