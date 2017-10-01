defmodule MicroblogWeb.Plugs do
  import Plug.Conn

  def fetch_user(conn, _opts) do
    user_id = get_session(conn, :user_id)
    if user_id do
      user = MicroblogWeb.Accounts.get_user!(user_id)
      assign(conn, :current_user, user)
    else
      assign(conn, :current_user, nil)
    end
  end


  # def fetch_cart(conn, _opts) do
  #   cart_id = get_session(conn, :cart_id)
  #   cart = NuMart.Shop.get_or_create_cart(cart_id)
  #   conn
  #   |> put_session(:cart_id, cart.id)
  #   |> assign(:current_cart, cart)
  # end
end
