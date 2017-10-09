defmodule MicroblogWeb.LikeController do
  use MicroblogWeb, :controller

  alias Microblog.Messages
  alias Microblog.Messages.Like

  action_fallback MicroblogWeb.FallbackController

  def index(conn, %{"post_id" => post_id}) do
    likes = Messages.list_post_likes(post_id)
    render(conn, "index.json", likes: likes)
  end

  def index(conn, %{"user_id" => user_id}) do
    likes = Messages.list_user_likes(user_id)
    render(conn, "index.json", likes: likes)
  end

  def index(conn, _params) do
    likes = Messages.list_likes()
    render(conn, "index.json", likes: likes)
  end

  def create(conn, %{"like" => like_params}) do
    with {:ok, %Like{} = like} <- Messages.create_like(like_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", like_path(conn, :show, like))
      |> render("show.json", like: like)
    end
  end

  def show(conn, %{"id" => id}) do
    like = Messages.get_like!(id)
    render(conn, "show.json", like: like)
  end

  def update(conn, %{"id" => id, "like" => like_params}) do
    like = Messages.get_like!(id)

    with {:ok, %Like{} = like} <- Messages.update_like(like, like_params) do
      render(conn, "show.json", like: like)
    end
  end

  def delete(conn, %{"id" => id}) do
    like = Messages.get_like!(id)
    with {:ok, %Like{}} <- Messages.delete_like(like) do
      send_resp(conn, :no_content, "")
    end
  end

  def delete(conn, %{"post_id" => post_id, "user_id" => user_id})) do
    like = Messages.get_like(post_id, user_id)
    with {:ok, %Like{}} <- Messages.delete_like(like) do
      send_resp(conn, :no_content, "")
    end
  end

end
