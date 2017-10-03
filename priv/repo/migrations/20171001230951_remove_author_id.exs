defmodule Microblog.Repo.Migrations.RemoveAuthorId do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      remove :authorId
	    end
  end
end
