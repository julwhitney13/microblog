defmodule Microblog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.User


  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :username, :string
    field :description, :string

    has_many :posts, Microblog.Messages.Post
    has_many :people_following, Microblog.Accounts.Relationship, foreign_key: :actor_id
    has_many :people_who_follow, Microblog.Accounts.Relationship, foreign_key: :receiver_id

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :username, :email, :description])
    |> validate_required([:firstname, :lastname, :username, :email, :description])
  end
end
