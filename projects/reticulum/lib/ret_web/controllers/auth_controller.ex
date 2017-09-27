defmodule RetWeb.AuthController do
  use RetWeb, :controller

  plug Ueberauth

  alias Ret.User
  alias Ret.Repo

  alias RetWeb.Router.Helpers

  def request(conn, params) do
  end

  def callback(%{ assigns: %{ ueberauth_failure: _failure }} = conn, _params) do
    conn
    |> put_flash(:error, "Failed to authenticate.")
    |> redirect(to: Helpers.page_path(conn, :index))
  end

  def callback(%{ assigns: %{ ueberauth_auth: auth }} = conn, params) do
    IO.inspect params
    perform_login(conn, Repo.get_by(User, email: auth.info.email), auth)
  end

  def perform_login(conn, nil, %Ueberauth.Auth{} = auth) do
    changeset = User.auth_changeset(%User{}, auth, %{ auth_provider: "google" })
    case Repo.insert(changeset) do
      { :ok, user } ->
        conn
        |> perform_login(user, auth)
      { :error, reason } ->
        conn
        |> json(%{ status: :error })
    end
      
  end

  def perform_login(conn, %User{} = user, %Ueberauth.Auth{} = _auth) do
    case get_format(conn) do
      "json" ->
        conn = Guardian.Plug.api_sign_in(conn, user)
        jwt = Guardian.Plug.current_token(conn)
        conn
        |> put_resp_header("authorization", "Bearer #{jwt}")
        |> json(%{ status: :OK, access_token: jwt })
      "html" ->
        conn
        |> Guardian.Plug.sign_in(user)
        |> put_session(:current_user, user)
        |> put_flash(:info, "Authenticated successfully.")
        |> redirect(to: Helpers.page_path(conn, :index))
    end
  end
   
end
