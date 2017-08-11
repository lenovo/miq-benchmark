require_relative 'profiling_manageiq'

class MiqBenchmark

  def initialize
    start
  end

  def start
    system("miq-docker start")
    system("bin/setup")
    system("rails runner '../miq-benchmark/seed_providers.rb'")
    profile = ProfileManageIQ.new
    profile.start
  end

end
MiqBenchmark.new