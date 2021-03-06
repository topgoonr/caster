defmodule Caster do
  @moduledoc """
    Main application module
  """
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Caster.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Caster.Endpoint, []),
      supervisor(Task.Supervisor, [[name: Caster.TaskSupervisor]])
      # Start your own worker by calling: Caster.Worker.start_link(arg1, arg2, arg3)
      # worker(Caster.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Caster.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Caster.Endpoint.config_change(changed, removed)
    :ok
  end
end
