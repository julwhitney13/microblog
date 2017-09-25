defmodule Microblog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.User


  schema "users" do
    field :description, :string
    field :email, :string
    field :firstname, :string
    field :followers, :integer
    field :following, :integer
    field :lastname, :string
    field :posts, :integer
    field :username, :string
    field :verified, :boolean, default: false

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :username, :email, :verified, :followers, :following, :posts, :description])
    |> validate_required([:firstname, :lastname, :username, :email, :verified, :followers, :following, :posts, :description])
  end
end
