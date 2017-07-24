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
                          mem, st = Open3.capture2("free -m | awk 'NR==2{printf $3*100/$2}'")
                          cpu, st = Open3.capture2("top -bn1 | grep load | awk '{printf $(NF-2)}'| sed s/.$//")
                          disk, st = Open3.capture2("df -h | awk '$NF==\"/\"{printf \"%.3f\", $5}'| sed s/.$//")

                          disks.push(disk)
                          mems.push(mem)
                          cpus.push(cpu)
                          break if @exit
                          sleep 1
                        end

                        result = {"mem":mems, "cpu":cpus, "disk":disks}
                        result
                      }
  end
end
