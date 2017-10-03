defmodule Microblog.Repo.Migrations.CreateRelationships do
  use Ecto.Migration

  def change do
    create table(:relationships) do
      add :actor_id, :integer
      add :receiver_id, :integer

      timestamps()
    end

  end
end
