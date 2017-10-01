defmodule Microblog.Messages.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Messages.Post


  schema "posts" do
    field :content, :string
    field :description, :string
    field :hashtags, {:array, :string}
    field :mentions, {:array, :integer}
    field :title, :string

    belongs_to :user, Microblog.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :description, :content, :hashtags, :mentions])
    |> validate_required([:title, :description, :content, :hashtags, :mentions])
  end
end
