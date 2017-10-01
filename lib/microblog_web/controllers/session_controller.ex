defmodule MicroblogWeb.SessionController do
  use MicroblogWeb, :controller

  alias MicroblogWeb.Accounts

  def login(conn, %{"email" => email}) do
    user = Accounts.get_user_by_email(email)

    if user do
    #   cart = conn.assigns[:current_cart]
    #   NuMart.Shop.update_cart(cart, %{user_id: user.id})

      conn
      |> put_session(:user_id, user.id)
      |> put_flash(:info, "Logged in as #{user.email}")
      |> redirect(to: post_path(conn, :index))
    else
      conn
      |> put_session(:user_id, nil)
      |> put_flash(:error, "No such user")
      |> redirect(to: post_path(conn, :index))
    end
  end

  def logout(conn, _args) do
    conn
    |> put_session(:user_id, nil)
    # |> put_session(:cart_id, nil)
    |> put_flash(:info, "Logged out.")
    |> redirect(to: post_path(conn, :index))
  end
end
