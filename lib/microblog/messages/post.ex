defmodule Microblog.Messages.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Messages.Post


  schema "posts" do
    field :authorId, :integer
    field :content, :string
    field :description, :string
    field :hashtags, {:array, :string}
    field :mentions, {:array, :integer}
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :description, :content, :authorId, :hashtags, :mentions])
    |> validate_required([:title, :description, :content, :authorId, :hashtags, :mentions])
  end
end
