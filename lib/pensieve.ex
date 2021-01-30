defmodule Pensieve do
  @moduledoc """
  Documentation for `Pensieve`.
  """

  # require Pensieve.Helpers, as: H

  @doc """
  """
  def connect do
  
    # Cisco IOS
    # :ssh.start()
    # ssh_opts = :ssh.chk_algos_opts([{:modify_algorithms, [{:append, [{:kex, [:"diffie-hellman-group-exchange-sha1"]}]}]}])


    :ssh.chk_algos_opts(
            [{:modify_algorithms,
            [{:prepend,
                [{:kex, ['diffie-hellman-group1-sha1']}]
          }
            ]
              }
            ])

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
      ],
      cisco: [
        # 'terminal length 0',
        # 'enable',
        'show clock',
        # 'show version',
        # 'show ip int brie',
        # 'show running-config'
      ]
    }

    devices = [
      %{
        ip: "192.168.255.150",
        hostname: "csr",
        vendor: :cisco,
        ssh_user: "admin",
        ssh_pass: "cisco",
      },
      # %{
      #   ip: "192.168.255.151",
      #   hostname: "vmx",
      #   vendor: :juniper,
      #   ssh_user: "admin",
      #   ssh_pass: "Juniper",
      # },
      # %{
      #   ip: "192.168.255.152",
      #   hostname: "veos",
      #   vendor: :arista,
      #   ssh_user: "admin",
      #   ssh_pass: "arista",
      # },
    ]

    Enum.each(devices, fn(device) -> 

      File.rm("#{device.hostname}.txt")

      {:ok, conn} = SSHEx.connect(ip: device.ip, user: device.ssh_user, password: device.ssh_pass, modify_algorithms: [{:append, [{:kex, [:"diffie-hellman-group-exchange-sha1"]}]}])

      Enum.each(commands[device.vendor], fn(command) -> 
        send_command(conn, command, device.hostname)
      end)
      # res = SSHEx.cmd!(conn, 'show clock')
      # IO.puts(res)

    end)

  end

  defp send_command(conn, command, hostname) do
    cmd = "####### #{command} #######\n"
    cwd = File.cwd!()
    File.write("#{cwd}/#{hostname}.txt", cmd, [:append])
    str = SSHEx.stream(conn, command)
    
    Enum.each(str, fn(x) ->
      case x do
        {:stdout, row} -> process_result(:stdout, row, hostname)
        {:stderr, row} -> process_result(:stderr, row, hostname)
        {:status, status} -> process_result(:status, status, hostname)
        {:error, reason} -> process_result(:error, reason, hostname)
      end
    end)
  end

  defp process_result(type, result, hostname) do
    # cwd = File.cwd!()
    # File.write("#{cwd}/#{hostname}.txt", result, [:append])
    IO.puts("#{hostname}: #{type}: #{result}")
  end

end