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

    cmd.flags.add do |flag|
      flag.name = "name"
      flag.short = "-n"
      flag.long = "--name"
      flag.default = "abc"
      flag.description = "the name of the tester "
    end

    cmd.run do |options, arguments|
      address = options.string["address"]
      server = options.string["server"]
      name = options.string["name"]

      puts "start testing..."

      output = IO::Memory.new
      Process.run("mtr", ["-jn", address], output: output)

      tmp_result = JSON.parse(output.to_s)
      # puts house.to_json
      output.close

      puts "test over , upload the report."
      test_id = Time.new.epoch_ms
      result = JSON.build do |json|
        json.object do
          json.field "name", name
          json.field "id", test_id
          json.field "data", tmp_result
        end
      end
      # puts result
      HTTP::Client.post(server, headers: HTTP::Headers{"Content-Type" => "application/json"}, body: result) do |response|
        puts response.body_io.gets # => "..."
        puts "test id : #{test_id}"
      end
    end
  end

  Commander.run(cli, ARGV)
end
