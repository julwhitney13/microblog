defmodule MicroblogWeb.RelationshipControllerTest do
  use MicroblogWeb.ConnCase

  alias Microblog.Accounts

  @create_attrs %{actor_id: 42, receiver_id: 42}
  @update_attrs %{actor_id: 43, receiver_id: 43}
  @invalid_attrs %{actor_id: nil, receiver_id: nil}

  def fixture(:relationship) do
    {:ok, relationship} = Accounts.create_relationship(@create_attrs)
    relationship
  end

  describe "create relationship" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, relationship_path(conn, :create), relationship: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == relationship_path(conn, :show, id)

      conn = get conn, relationship_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Relationship"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, relationship_path(conn, :create), relationship: @invalid_attrs
      assert html_response(conn, 200) =~ "New Relationship"
    end
  end

  describe "delete relationship" do
    setup [:create_relationship]

    test "deletes chosen relationship", %{conn: conn, relationship: relationship} do
      conn = delete conn, relationship_path(conn, :delete, relationship)
      assert redirected_to(conn) == relationship_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, relationship_path(conn, :show, relationship)
      end
    end
  end

  defp create_relationship(_) do
    relationship = fixture(:relationship)
    {:ok, relationship: relationship}
  end
end
