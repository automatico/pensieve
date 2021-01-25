require Pensieve.Helpers, as: H

defmodule Pensieve do
  @moduledoc """
  Documentation for `Pensieve`.
  """

  @doc """
  """
  :ssh.start()
  def connect do
    credentials = H.credentials
    ssh_user = credentials.ssh_user
    ssh_pass = credentials.ssh_pass

    {:ok, conn} = SSHEx.connect ip: '#', user: ssh_user, password: ssh_pass
    {:ok, stdout, stderr, 2} = SSHEx.run conn, '...', separate_streams: true
    IO.puts "stdout: #{stdout}"
    IO.puts "stderr: #{stderr}"
  end
end
