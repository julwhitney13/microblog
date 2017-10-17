defmodule Microblog.AccountsTest do
  use Microblog.DataCase

  alias Microblog.Accounts

  describe "users" do
    alias Microblog.Accounts.User

    @valid_attrs %{description: "some description", email: "some email", firstname: "some firstname", lastname: "some lastname", username: "some username"}
    @update_attrs %{description: "some updated description", email: "some updated email", firstname: "some updated firstname", lastname: "some updated lastname", username: "some updated username"}
    @invalid_attrs %{description: nil, email: nil, firstname: nil, lastname: nil, username: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.description == "some description"
      assert user.email == "some email"
      assert user.firstname == "some firstname"
      assert user.lastname == "some lastname"
      assert user.username == "some username"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.description == "some updated description"
      assert user.email == "some updated email"
      assert user.firstname == "some updated firstname"
      assert user.lastname == "some updated lastname"
      assert user.username == "some updated username"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "relationships" do
    alias Microblog.Accounts.Relationship

    @valid_attrs %{actor_id: 42, receiver_id: 4}
    @update_attrs %{actor_id: 4, receiver_id: 42}
    @invalid_attrs %{actor_id: nil, receiver_id: nil}

    def relationship_fixture(attrs \\ %{}) do
      {:ok, relationship} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_relationship()

      relationship
    end

    test "list_relationships/0 returns all relationships" do
      relationship = relationship_fixture()
      assert Accounts.list_relationships() == [relationship]
    end

    test "get_relationship!/1 returns the relationship with given id" do
      relationship = relationship_fixture()
      assert Accounts.get_relationship!(relationship.id) == relationship
    end

    test "create_relationship/1 with valid data creates a relationship" do
      assert {:ok, %Relationship{} = relationship} = Accounts.create_relationship(@valid_attrs)
      assert relationship.actor_id == 42
      assert relationship.receiver_id == 4
    end

    test "create_relationship/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_relationship(@invalid_attrs)
    end

    test "update_relationship/2 with valid data updates the relationship" do
      relationship = relationship_fixture()
      assert {:ok, relationship} = Accounts.update_relationship(relationship, @update_attrs)
      assert %Relationship{} = relationship
      assert relationship.actor_id == 4
      assert relationship.receiver_id == 42
    end

    test "update_relationship/2 with invalid data returns error changeset" do
      relationship = relationship_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_relationship(relationship, @invalid_attrs)
      assert relationship == Accounts.get_relationship!(relationship.id)
    end

    test "delete_relationship/1 deletes the relationship" do
      relationship = relationship_fixture()
      assert {:ok, %Relationship{}} = Accounts.delete_relationship(relationship)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_relationship!(relationship.id) end
    end

    test "change_relationship/1 returns a relationship changeset" do
      relationship = relationship_fixture()
      assert %Ecto.Changeset{} = Accounts.change_relationship(relationship)
    end
  end
end
