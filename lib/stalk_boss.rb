module Stalker
  def soft_quit?
    @soft_quit ||= false
  end

  def soft_quit=(soft_quit)
    @soft_quit = soft_quit
  end
  
  alias :work_one_job_stalker :work_one_job

  def work_one_job
    exit if soft_quit?
    work_one_job_stalker
  end
  
end
module StalkBoss
    class Stalk
      attr_accessor :pipes, :worker, :workers, :log
      
      def pipes
        @pipes ||= []
      end
      
      def initialize(worker, workers=1, log=nil)
        super
        @worker  = worker
        @workers = workers
        @log     = log
      end
      
      def pids
        @pipes.map(&:pid) unless @pipe.nil?
      end
      
      def start
        (1..@workers).each do
          pipes << IO.popen("bossed_stalk #{@worker} > #{@log} 2>&1")
        end
      end
      
      
    end
    
    def stalk_jobs
      @stalk_jobs ||= []
    end
    
    def stalk_job(worker, options={}, &block)
      stalk = Stalk.new(worker, options[:workers], options[:log])
      yield(stalk) if block_given?
      stalk_jobs << stalk
      stalk
    end
    
    def term
      send_signal('INT')
    end

    def soft_quit
      send_signal('QUIT')
    end
    
    def start
      stalk_jobs.each{ |s| s.start }
    end
    
    private
    
    def send_signal(sig)
      stalk_jobs.each do |s| 
        s.pids.each do |pid|
          Process.kill sig, pid 
        end
      end
      stalk_jobs = []
    end
    
end
