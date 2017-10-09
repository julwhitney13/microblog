defmodule MicroblogWeb.Router do
  use MicroblogWeb, :router
  import MicroblogWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug NavigationHistory.Tracker
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_user
  end

  scope "/", MicroblogWeb do
    pipe_through :browser # Use the default browser stack
    resources "/users", UserController
    resources "/posts", PostController
    delete "/relationships", RelationshipController, :delete
    resources "/relationships", RelationshipController, except: [:show, :new, :index, :update, :edit, :delete]

    get "/", PageController, :index


    post "/sessions", SessionController, :login
    delete "/sessions", SessionController, :logout
  end

  # Other scopes may use custom stacks.
  scope "/api", MicroblogWeb do
    pipe_through :api
    # resources "/likes", LikeController, except: [:new, :edit]
    resources "/likes", LikeController, except: [:new, :edit, :delete]
    delete "/likes", LikeController, :delete
  end
end
