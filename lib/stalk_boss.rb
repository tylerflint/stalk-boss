module Stalker
  def soft_quit?
    @soft_quit = false if @soft_quit.nil?
    @soft_quit
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
      attr_accessor :pipe, :worker, :log
      
      def initialize(worker, log=nil?)
        super
        @worker = worker
        @log    = log
      end
      
      def pid
        @pipe.pid unless @pipe.nil?
      end
      
      def start
        @pipe = IO.popen("bossed_stalk #{@worker} #{@log}")
      end
      
    end
    
    def stalk_jobs
      @stalk_jobs ||= []
    end
    
    def stalk_job(worker, options={}, &block)
      stalk = Stalk.new(worker, options[:log])
      yield(stalk) if block_given?
      stalk_jobs << stalk
      stalk
    end
    
    def term
      stalk_jobs.each{ |s| Process.kill 'INT', s.pid }
    end

    def soft_quit
      stalk_jobs.each{ |s| Process.kill 'QUIT', s.pid }
    end
    
    def start
      stalk_jobs.each{ |s| s.start }      
    end
    
end
