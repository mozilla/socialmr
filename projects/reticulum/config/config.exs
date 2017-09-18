# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ret,
  ecto_repos: [Ret.Repo]

# Configures the endpoint
config :ret, RetWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "txlMOtlaY5x3crvOCko4uV5PM29ul3zGo1oBGNO3cDXx+7GHLKqt0gR9qzgThxb5",
  render_errors: [view: RetWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ret.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ueberauth, Ueberauth,
  base_path: "/api/v1/auth",
  providers: [
    google: { Ueberauth.Strategy.Google, [] },
    identity: { Ueberauth.Strategy.Identity, [
                  callback_methods: ["POST"],
                  uid_field: :username,
                  nickname_field: :username,
                ] },
  ]

# Ueberauth Strategy Config for Google oauth
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
  redirect_uri: System.get_env("GOOGLE_REDIRECT_URI")

# Guardian configuration
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "SocialAppApi",
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "JpWapNaJQ4HU1spmFCb5EyWxJAwKXiCl8677nd2GWYCurPYXYksMsHIV3J8zsYvN",
  serializer: SocialAppApi.GuardianSerializer

config :ret, Ret.Repo,
  migration_source: "schema_migrations",
  after_connect: { Ret.Repo, :set_search_path, ["ret0, public"] }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
