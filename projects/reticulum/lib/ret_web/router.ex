defmodule RetWeb.Router do
  use RetWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :browser_auth do
    plug Guardian.Plug.VerifySession
    plug Guardian.Plug.LoadResource
    plug Ret.Plug.Session
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug JaSerializer.Deserializer
  end

  scope "/", RetWeb do
    pipe_through [:browser, :browser_auth]

    get "/", PageController, :index
  end

  scope "/api/login", RetWeb do
    pipe_through [:api, :browser]

    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
    post "/:provider/callback", AuthController, :callback
  end
end
