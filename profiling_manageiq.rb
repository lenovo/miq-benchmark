require 'open3'
require_relative 'monitor_system'
require 'csv'

class ProfileManageIQ
  def start
    puts "Logging in the VPN...\n"
    system("sudo openconnect -b --script=~/vpn.sh webvpn.us.lenovo.com")
    main
    clean_enviroment
  end

  def main
    monitor = MonitorSystem.new

    # start monitor system usage of the memory, cpu and disk.
    monitor.start
    time_evm_start = start_evm
    time_refresh_first = refresh("first")
    time_refresh_all = refresh("all")
    time_evm_stop = stop_evm
    system_usage = monitor.stop #stop de monitor system usage

    CSV.open("../miq-benchmark/profiling_result.csv", "wb") do |csv|
      csv << ["time_evm_start", "time_evm_stop", "time_refresh_first", "time_refresh_all", "memory_usage", "cpu_usage", "disk_usage"]
      csv << [time_evm_start, time_evm_stop, time_refresh_first, time_refresh_all, system_usage[:mem], system_usage[:cpu], system_usage[:disk]]
    end
    puts "Result wrote in this file: profiling_result.csv"
    puts "Time EVM Start: #{time_evm_start}", "Time EVM Stop: #{time_evm_stop}",
         "Time Refresh one provider: #{time_refresh_first}", "Time Refresh all providers: #{time_refresh_all}",
         "System Usage: #{system_usage}"
  end

  def start_evm
    start_time = Time.now
    out, st = Open3.capture2("bundle exec rails evm:start")
    loop do
      out, st = Open3.capture2("bundle exec rails evm:status | awk 'FNR == 5 { print $5;}'")
      break if out == "started\n"
      sleep 1
    end
    end_time = Time.now
    diff = end_time - start_time

    puts "EVM:ManageIQ started!"
    diff
  end

  def stop_evm
    start_time = Time.now
    out, st = Open3.capture2("bundle exec rails evm:stop")
    loop do
      out, st = Open3.capture2("bundle exec rails evm:status | awk 'FNR == 5 { print $5;}'")
      break if out == "stopped\n"
      sleep 1
    end
    end_time = Time.now
    diff = end_time - start_time

    puts "EVM:ManageIQ stoped!"
    diff
  end

  def refresh(elem)
    start_time = Time.now

    if elem == 'all'
      out, st = Open3.capture2("bundle exec rails runner 'ExtManagementSystem.all.collect {|provider| EmsRefresh.refresh provider }'")
    else
      out, st = Open3.capture2("bundle exec rails runner 'EmsRefresh.refresh ExtManagementSystem.#{elem}'")
    end

    end_time = Time.now
    diff = end_time - start_time

    if st.exitstatus.to_i == 0
      puts "#{elem} refresh OK!"
    else
      puts "Error while Refreshing #{out}"
    end
    diff
  end

  def clean_enviroment
    system("miq-docker recreate")
    system("sudo reboot")
  end
end
