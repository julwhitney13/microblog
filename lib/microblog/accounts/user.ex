defmodule Microblog.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Microblog.Accounts.User
  alias Microblog.Propic

  schema "users" do
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :username, :string
    field :description, :string

    field :password_hash, :string
    field :pw_tries, :integer
    field :pw_last_try, :utc_datetime

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    field :propic, Microblog.Propic.Type

    has_many :posts, Microblog.Messages.Post
    has_many :following, Microblog.Accounts.Relationship, foreign_key: :actor_id
    has_many :followers, Microblog.Accounts.Relationship, foreign_key: :receiver_id
    has_many :likes, Microblog.Messages.Like

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:firstname, :lastname, :username, :email, :description, :password, :password_confirmation])
    |> cast_attachments(params, [:photo])
    |> validate_confirmation(:password)
    |> validate_password(:password)
    |> put_pass_hash()
    |> validate_required([:firstname, :lastname, :username, :email, :description, :password_hash, :propic])
  end


    # Password validation
    # From Comeonin docs
    # These functions were also referenced from NuMart by Nat Tuck https://github.com/NatTuck/nu_mart
    def validate_password(changeset, field, options \\ []) do
      validate_change(changeset, field, fn _, password ->
        case valid_password?(password) do
          {:ok, _} -> []
          {:error, msg} -> [{field, options[:message] || msg}]
        end
      end)
    end

    def put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
      change(changeset, Comeonin.Argon2.add_hash(password))
    end

    def put_pass_hash(changeset), do: changeset

    def valid_password?(password) when byte_size(password) > 7 do
      {:ok, password}
    end

    def valid_password?(_), do: {:error, "The password is too short"}
end
