defmodule MicroblogWeb.RelationshipController do
  use MicroblogWeb, :controller

  alias Microblog.Accounts
  alias Microblog.Accounts.Relationship

  # def index(conn, _params) do
  #   relationships = Accounts.list_relationships()
  #   render(conn, "index.html", relationships: relationships)
  # end
  #
  # def new(conn, _params) do
  #   changeset = Accounts.change_relationship(%Relationship{})
  #   render(conn, "new.html", changeset: changeset)
  # end
  #
  # def create(conn, %{"relationship" => relationship_params}) do

  def create(conn, relationship_params) do
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

  # def show(conn, %{"id" => id}) do
  #   relationship = Accounts.get_relationship!(id)
  #   render(conn, "show.html", relationship: relationship)
  # end
  #
  # def edit(conn, %{"id" => id}) do
  #   relationship = Accounts.get_relationship!(id)
  #   changeset = Accounts.change_relationship(relationship)
  #   render(conn, "edit.html", relationship: relationship, changeset: changeset)
  # end
  #
  # def update(conn, %{"id" => id, "relationship" => relationship_params}) do
  #   relationship = Accounts.get_relationship!(id)
  #
  #   case Accounts.update_relationship(relationship, relationship_params) do
  #     {:ok, relationship} ->
  #       conn
  #       |> put_flash(:info, "Relationship updated successfully.")
  #       |> redirect(to: relationship_path(conn, :show, relationship))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", relationship: relationship, changeset: changeset)
  #   end
  # end

  # def get_or_create(conn, %{"id" => id}) do
  #     case Accounts.get_or_create_relationship(id) do
  #       {:ok, relationship} ->
  #         conn
  #         |> put_flash(:info, "User followed successfully.")
  #       #   |> redirect(to: user_path(conn, :show, relationship.receiver_id))
  #       {:error, %Ecto.Changeset{} = changeset} ->
  #        conn
  #         |> put_flash(:error, "Error unfollowing user.")
  #       #   |> redirect(to: user_path(conn, :show, relationship.receiver_id))
  #     end
  # end

  def delete(conn, relationship_params) do
    relationship = Accounts.get_relationship(relationship_params.actor_id, relationship_params.receiver_id)
    {:ok, _relationship} = Accounts.delete_relationship(relationship)

    conn
    |> put_flash(:info, "User unfollowed successfully.")
    |> redirect(to: user_path(conn, :show, relationship.receiver_id))
  end
end
