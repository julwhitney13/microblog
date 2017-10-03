defmodule MicroblogWeb.RelationshipController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts
  alias Microblog.Accounts.Relationship

  def create(conn, %{"relationship" => relationship_params}) do
    case Accounts.create_relationship(relationship_params) do
      {:ok, relationship} ->
        conn
        |> put_flash(:info, "User followed successfully.")
        |> redirect(to: NavigationHistory.last_path(conn, default: user_path(conn, :index)))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Error unfollowing user.")
        |> redirect(to: NavigationHistory.last_path(conn, default: user_path(conn, :index)))
    end
  end

  # Delete without the :id since it gets the relationship to delete from the params
  def delete(conn, %{"relationship" => relationship_params}) do
    relationship = Accounts.get_relationship(relationship_params["actor_id"], relationship_params["receiver_id"])
    {:ok, _relationship} = Accounts.delete_relationship(relationship)

    conn
    |> put_flash(:info, "User unfollowed successfully.")
    |> redirect(to: user_path(conn, :show, relationship_params["receiver_id"]))
  end
end
