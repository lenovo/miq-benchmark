class SeedProviders

  def initialize
    puts "Insert the provider case (small, big or all): "
    seed_providers(gets.downcase.chomp)
    puts "seed providers successfully!"
  end

  def seed_providers(provider_case)
    auth = read_auth_providers
    hosts = read_hosts_providers

    case provider_case
      when "small"
        create_provider(auth[0][:username], auth[0][:password], auth[0][:hostname], 0)
      when "big"
        puts "Insert your it code"
        username = gets
        puts "Insert your password: "
        password = STDIN.noecho(&:gets)
        create_provider(username, password, hosts[0], 0)
      when "all"
        puts "Insert your it code"
        username = gets
        puts "Insert your password: "
        password = STDIN.noecho(&:gets)
        index = 0
        hosts.each do |host|
          create_provider(username, password, host, index)
          index+=1
        end
        auth.each do |auth|
          create_provider(auth[:username], auth[:password], auth[:hostname], index)
          index+=1
        end
      else
        "invalid option!"
    end
  end

  def create_provider(username, password, hostname, index)

    auth = Authentication.new({:userid=> username, :password=> password})
    data_ext = {
      :name=> "lxca #{index}",
      :type=> "ManageIQ::Providers::Lenovo::PhysicalInfraManager",
      :authentications=> [auth],
      :hostname=> hostname,
      :port => 443,
      :zone_id=> 1
    }
    ext = ExtManagementSystem.new(data_ext)
    puts ext
    ext.save!
  end

  def read_auth_providers
    begin
      result = []
      file = File.new("../miq-benchmark/auth.txt", "r")
      while (line = file.gets)
        temp = line.split(",")
        data = {:hostname=>temp[0], :username=>temp[1], :password=>temp[2].gsub("\n","")}
        result.push(data)
      end
      file.close
      result
    rescue => err
      puts "Exception: #{err}"
    end
  end

  def read_hosts_providers
    begin
      result = []
      file = File.new("../miq-benchmark/auth1.txt", "r")
      while (line = file.gets)
        result.push(line.gsub("\n",""))
      end
      file.close
      result
    rescue => err
      puts "Exception: #{err}"
    end
  end
end
SeedProviders.new