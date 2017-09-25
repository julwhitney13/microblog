defmodule Microblog.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :description, :text
      add :content, :text
      add :authorId, :integer
      add :hashtags, {:array, :string}
      add :mentions, {:array, :integer}

      timestamps()
    end

  end
end
