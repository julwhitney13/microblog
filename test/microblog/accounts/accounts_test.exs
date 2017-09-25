defmodule Microblog.AccountsTest do
  use Microblog.DataCase

  alias Microblog.Accounts

  describe "users" do
    alias Microblog.Accounts.User

    @valid_attrs %{description: "some description", email: "some email", firstname: "some firstname", followers: 42, following: 42, lastname: "some lastname", posts: 42, userID: 42, username: "some username", verified: true}
    @update_attrs %{description: "some updated description", email: "some updated email", firstname: "some updated firstname", followers: 43, following: 43, lastname: "some updated lastname", posts: 43, userID: 43, username: "some updated username", verified: false}
    @invalid_attrs %{description: nil, email: nil, firstname: nil, followers: nil, following: nil, lastname: nil, posts: nil, userID: nil, username: nil, verified: nil}

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
      assert user.followers == 42
      assert user.following == 42
      assert user.lastname == "some lastname"
      assert user.posts == 42
      assert user.userID == 42
      assert user.username == "some username"
      assert user.verified == true
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
      assert user.followers == 43
      assert user.following == 43
      assert user.lastname == "some updated lastname"
      assert user.posts == 43
      assert user.userID == 43
      assert user.username == "some updated username"
      assert user.verified == false
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

  describe "users" do
    alias Microblog.Accounts.User

    @valid_attrs %{description: "some description", email: "some email", firstname: "some firstname", followers: 42, following: 42, lastname: "some lastname", posts: 42, username: "some username", verified: true}
    @update_attrs %{description: "some updated description", email: "some updated email", firstname: "some updated firstname", followers: 43, following: 43, lastname: "some updated lastname", posts: 43, username: "some updated username", verified: false}
    @invalid_attrs %{description: nil, email: nil, firstname: nil, followers: nil, following: nil, lastname: nil, posts: nil, username: nil, verified: nil}

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
      assert user.followers == 42
      assert user.following == 42
      assert user.lastname == "some lastname"
      assert user.posts == 42
      assert user.username == "some username"
      assert user.verified == true
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
      assert user.followers == 43
      assert user.following == 43
      assert user.lastname == "some updated lastname"
      assert user.posts == 43
      assert user.username == "some updated username"
      assert user.verified == false
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
end
