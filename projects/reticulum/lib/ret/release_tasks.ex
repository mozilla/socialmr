defmodule Ret.ReleaseTasks do
  @start_apps [:crypto, :ssl, :postgrex, :ecto]

  def migrate do
    :ok = Application.load(:ret)
    Enum.each(@start_apps, &Application.ensure_all_started/1)
    Ret.Repo.start_link(pool_size: 1)
    Ecto.Migrator.run(Ret.Repo, migrations_path(:ret), :up, all: true)
    :init.stop()
  end

  def priv_dir(app), do: "#{:code.priv_dir(app)}"
  defp migrations_path(app), do: Path.join([priv_dir(app), "repo", "migrations"])
end
