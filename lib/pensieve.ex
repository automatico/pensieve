defmodule Pensieve do
  @moduledoc """
  Documentation for `Pensieve`.
  """

  # require Pensieve.Helpers, as: H

  @doc """
  """

  :ssh.start()

  def connect do

    commands = %{
      juniper: [
        'set cli screen-length 0',
        'set cli screen-width 0',
        'show system uptime',
        'show interfaces terse',
        'show configuration | display set'
      ],
      arista: [
        'terminal length 0',
        'enable',
        'show clock',
        'show version',
        'show ip int brie',
        'show running-config'
      ]
    }

    devices = [
      %{
        ip: "192.168.255.151",
        vendor: :juniper,
        ssh_user: "admin",
        ssh_pass: "Juniper",
      },
      %{
        ip: "192.168.255.152",
        vendor: :arista,
        ssh_user: "admin",
        ssh_pass: "arista",
      },
    ]

    Enum.each(devices, fn(device) -> 

      {:ok, conn} = SSHEx.connect(ip: device.ip, user: device.ssh_user, password: device.ssh_pass)
    
      Enum.each(commands[device.vendor], fn(command) -> 
        send_command(conn, command)
      end)

    end)

  end

  defp send_command(conn, command) do
    
    IO.puts("##############  #{command}  ##############")

    str = SSHEx.stream(conn, command)
    
    Enum.each(str, fn(x) ->
      case x do
        {:stdout, row} -> process_result(:stdout, row)
        {:stderr, row} -> process_result(:stderr, row)
        {:status, status} -> process_result(:status, status)
        {:error, reason} -> process_result(:error, reason)
      end
    end)
  end

  defp process_result(type, result) do
    IO.puts("#{type}: #{result}")
  end

end