require "./mtr/*"
require "json"
require "http/client"
require "commander"

module Mtr
  cli = Commander::Command.new do |cmd|
    cmd.use = "mtr"
    cmd.long = "MTR command wrapper , and send the report to the server "

    cmd.flags.add do |flag|
      flag.name = "address"
      flag.short = "-a"
      flag.long = "--address"
      flag.default = "baidu.com"
      flag.description = "The address for mtr test."
    end

    cmd.flags.add do |flag|
      flag.name = "server"
      flag.short = "-s"
      flag.long = "--server"
      flag.default = "http://localhost:3000/record"
      flag.description = "The server for storing the report."
    end

    cmd.run do |options, arguments|
      address = options.string["address"]
      server = options.string["server"]

      puts "start testing..."

      output = IO::Memory.new
      Process.run("mtr", ["-jn", "baidu.com"], output: output)
      result = output.to_s
      output.close

      # puts result
      HTTP::Client.post(server, headers: HTTP::Headers{"Content-Type" => "application/json"}, body: result) do |response|
        puts response.body_io.gets # => "..."
      end
    end
  end

  Commander.run(cli, ARGV)
end
