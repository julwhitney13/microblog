defmodule Microblog.Messages do
  @moduledoc """
  The Messages context.
  """

  import Ecto.Query, warn: false
  alias Microblog.Repo

  alias Microblog.Messages.Post
  import Pandex
  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def convert_md_to_html(string)  do
      {:ok, output} = markdown_to_html string
      IO.puts output
  end

  def list_posts do
    Repo.all(Post, order_by: [desc: :updated_at])
    |> Repo.preload(:user)
    |> Repo.preload(:likes)
  end

  @doc """
  Gets a single post.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post!(123)
      %Post{}

      iex> get_post!(456)
      ** (Ecto.NoResultsError)

  """
  def get_post!(id) do
      Repo.get!(Post, id)
      |> Repo.preload(:user)
      |> Repo.preload(:likes)
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a post.

  ## Examples

      iex> update_post(post, %{field: new_value})
      {:ok, %Post{}}

      iex> update_post(post, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Post.

  ## Examples

      iex> delete_post(post)
      {:ok, %Post{}}

      iex> delete_post(post)
      {:error, %Ecto.Changeset{}}

  """
  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{source: %Post{}}

  """
  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  alias Microblog.Messages.Like


  def list_post_likes(post_id) do
      Repo.all(from l in Like, where: l.post_id == ^post_id)
      |> Repo.preload(:user)
      |> Repo.preload(:post)
  end

  def list_user_likes(user_id) do
      Repo.all(from l in Like, where: l.user_id == ^user_id)
      |> Repo.preload(:user)
      |> Repo.preload(:post)
  end

  def user_has_liked?(user_id, post_id) do
      !!Repo.get_by(Like, user_id: user_id, post_id: post_id)
  end

  def broadcast_to_followers(author_id, broadcast_params) do
      followers = Microblog.Accounts.get_followers(author_id)
      if !!followers do
          for fid <- followers do
              MicroblogWeb.Endpoint.broadcast("updates:" <> Integer.to_string(fid), "new_message_posted", broadcast_params)
          end
      end
      MicroblogWeb.Endpoint.broadcast("updates:" <> Integer.to_string(author_id), "new_message_posted", broadcast_params)
  end
  @doc """
  Returns the list of likes.

  ## Examples

      iex> list_likes()
      [%Like{}, ...]

  """
  def list_likes do
    Repo.all(Like)
    |> Repo.preload(:user)
    |> Repo.preload(:post)
  end

  @doc """
  Gets a single like.

  Raises `Ecto.NoResultsError` if the Like does not exist.

  ## Examples

      iex> get_like!(123)
      %Like{}

      iex> get_like!(456)
      ** (Ecto.NoResultsError)

  """
  def get_like!(id) do
      Repo.get!(Like, id)
      |> Repo.preload(:user)
      |> Repo.preload(:post)
  end


  def get_like(post_id, user_id) do
      Repo.get_by(Like, user_id: user_id, post_id: post_id)
  end

  @doc """
  Creates a like.

  ## Examples

      iex> create_like(%{field: value})
      {:ok, %Like{}}

      iex> create_like(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_like(attrs \\ %{}) do
    %Like{}
    |> Like.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a like.

  ## Examples

      iex> update_like(like, %{field: new_value})
      {:ok, %Like{}}

      iex> update_like(like, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_like(%Like{} = like, attrs) do
    like
    |> Like.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Like.

  ## Examples

      iex> delete_like(like)
      {:ok, %Like{}}

      iex> delete_like(like)
      {:error, %Ecto.Changeset{}}

  """
  def delete_like(%Like{} = like) do
    Repo.delete(like)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking like changes.

  ## Examples

      iex> change_like(like)
      %Ecto.Changeset{source: %Like{}}

  """
  def change_like(%Like{} = like) do
    Like.changeset(like, %{})
  end
end
