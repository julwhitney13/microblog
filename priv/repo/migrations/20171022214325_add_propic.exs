defmodule Microblog.Repo.Migrations.AddPropic do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :propic, :string
    end
  end
end
