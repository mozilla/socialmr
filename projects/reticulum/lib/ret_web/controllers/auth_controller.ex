defmodule RetWeb.AuthController do
  use RetWeb, :controller

  plug Ueberauth

  alias Ret.User
  alias Ret.Repo

  def request(_params) do
  end

  def callback(%{ assigns: %{ ueberauth_failure: _failure }} = conn, _params) do
  end

  def callback(%{ assigns: %{ ueberauth_auth: auth }} = conn, _params) do
    email = auth.info.email
    perform_login(conn, Repo.get_by(User, email: email), auth)
  end

  def perform_login(conn, nil, %Ueberauth.Auth{} = auth) do
    user = User.auth_changeset(%User{}, auth, %{ auth_provider: "google" })
    |> Repo.insert

    perform_login(conn, user, auth)
  end

  def perform_login(conn, %User{} = user, %Ueberauth.Auth{} = auth) do
    { :ok, jwt, _ } = Guardian.encode_and_sign(user, :token)
    IO.puts "JWT 1: #{jwt}"
    conn = Guardian.Plug.api_sign_in(conn, user)
    jwt = Guardian.Plug.current_token(conn)
    IO.puts "JWT 2: #{jwt}"

    conn
    |> put_resp_header("authorization", "Bearer #{jwt}")
    |> json(%{ status: :OK, access_token: jwt })
  end
end
