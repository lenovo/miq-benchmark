require 'open3'

class MonitorSystem
  def start
    monitor_system_usage
  end

  def stop
    @exit = true
    @thr.join
    @thr.value
  end

  private

  def monitor_system_usage
    @exit = false

    @thr = Thread.start{
                        mems = []
                        cpus = []
                        disks = []
                        loop do
                          begin
                            mem, st = Open3.capture2("free -m | awk 'NR==2{printf \"%.2f\", ($3*100)/$2}'")
                            cpu, st1 = Open3.capture2("top -bn1 | grep load | awk '{printf $(NF-2)}'| sed s/.$//")
                            disk, st2 = Open3.capture2("df -h | awk '$NF==\"/\"{printf \"%.3f\", $5}'| sed s/.$//")

                            mems.push(mem) unless mem.empty?
                            cpus.push(cpu) unless cpu.empty?
                            disks.push(disk) unless disk.empty?

                            break if @exit
                            sleep 1
                          rescue
                            mems.push("99.97")
                            sleep 1
                          end
                        end

                        result = {"mem":mems, "cpu":cpus, "disk":disks}
                        result
                      }
  end
end
