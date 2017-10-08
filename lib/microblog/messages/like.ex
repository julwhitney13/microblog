defmodule Microblog.Messages.Like do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Messages.Like


  schema "likes" do
    field :post_id, :integer
    field :user_id, :integer

    belongs_to :user, Microblog.Accounts.User
    belongs_to :post, Microblog.Messages.Post
    
    timestamps()
  end

  @doc false
  def changeset(%Like{} = like, attrs) do
    like
    |> cast(attrs, [:user_id, :post_id])
    |> validate_required([:user_id, :post_id])
  end
end
