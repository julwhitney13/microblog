defmodule Microblog.Accounts.Relationship do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.Relationship


  schema "relationships" do
    field :actor_id, :integer
    field :receiver_id, :integer

    timestamps()
  end

  @doc false
  def changeset(%Relationship{} = relationship, attrs) do
    relationship
    |> cast(attrs, [:actor_id, :receiver_id])
    |> validate_required([:actor_id, :receiver_id])
  end
end
