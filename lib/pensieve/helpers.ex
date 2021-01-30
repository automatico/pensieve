defmodule Pensieve.Helpers do
  def credentials do
    ssh_user = System.get_env("SSH_USER")
    ssh_pass = System.get_env("SSH_PASS")
    {:ok, ssh_user, ssh_pass}
  end

  def devices do
    cwd = File.cwd!()
    {:ok, file} = File.open("#{cwd}devices.json")
    data = Jason.decode(file)
    data
  end
end
