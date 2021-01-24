defmodule Pensieve do
  @moduledoc """
  Documentation for `Pensieve`.
  """

  @doc """
  """
  :ssh.start()
  def connect do
    {:ok, conn} = SSHEx.connect ip: '#', user: '#', password: '#'
    {:ok, stdout, stderr, 2} = SSHEx.run conn, '...', separate_streams: true
    IO.puts "stdout: #{stdout}" 
    IO.puts "stderr: #{stderr}"
  end
end
