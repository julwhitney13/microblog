defmodule MicroblogWeb.PostController do
  use MicroblogWeb, :controller

  alias Microblog.Messages
  alias Microblog.Messages.Post

  def index(conn, _params) do
    posts = Messages.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Messages.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    case Messages.create_post(post_params) do
      {:ok, post} ->
        author = Microblog.Accounts.get_user!(post_params["user_id"])
        broadcast_params = Map.put(post_params, "username", author.username)
        Messages.broadcast_to_followers(author.id, broadcast_params)
        conn
        |> put_flash(:info, "Post created successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = Messages.get_post!(id)
    render(conn, "show.html", post: post)
  end

  def edit(conn, %{"id" => id}) do
    post = Messages.get_post!(id)
    changeset = Messages.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Messages.get_post!(id)

    case Messages.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Post updated successfully.")
        |> redirect(to: post_path(conn, :show, post))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Messages.get_post!(id)
    {:ok, _post} = Messages.delete_post(post)

    conn
    |> put_flash(:info, "Post deleted successfully.")
    |> redirect(to: post_path(conn, :index))
  end
end
