defmodule Microblog.Messages.Post do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Messages.Post


  schema "posts" do
    field :content, :string
    field :description, :string
    field :hashtags, {:array, :string}
    field :title, :string

    has_many :like, Microblog.Messages.Like

    belongs_to :user, Microblog.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(%Post{} = post, attrs) do
    post
    |> cast(attrs, [:title, :description, :content, :hashtags, :user_id])
    |> validate_required([:title, :description, :content])
  end
end
