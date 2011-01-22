module Stalker
  def soft_quit?
    @soft_quit ||= false
  end

  def soft_quit=(soft_quit)
    exit if !job_in_progress? && soft_quit
    @soft_quit = soft_quit
  end
  
  def job_in_progress?
    @in_progress ||= false
  end
  
  alias :work_one_job_stalker :work_one_job
  alias :log_job_begin_stalker :log_job_begin
  alias :log_job_end_stalker :log_job_end
  
  def work_one_job
    exit if soft_quit?
    work_one_job_stalker
  end
  
  def log_job_begin(name, args)
    @in_progress = true
    log_job_begin_stalker(name, args)
  end
  
  def log_job_end(name, failed=false)
    @in_progress = false
    log_job_end_stalker(name, failed)
  end
  
end
module StalkBoss
    class Stalk
      attr_accessor :worker, :workers, :log, :error_log
      
      def initialize(worker, workers=1, log=nil, error_log=nil)
        super
        @worker    = worker
        @workers   = workers
        @log       = log
        @error_log = error_log
      end
      
      def pids
        @pids ||= []
      end
      
      def start
        (1..@workers).each do
          pids << fork do
            STDOUT.reopen(File.open(@log, 'a')) if @log
            STDERR.reopen(File.open(@error_log, 'a')) if @error_log
            STDERR.sync = STDOUT.sync = true
            exec 'bossed_stalk', @worker
          end
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
          Process.detach pid
          rescue Errno::ESRCH, Errno::ENOENT
            # do nothing, we don't care if were missing a pid that we're
            # trying to murder already
        end
      end
      stalk_jobs = []
    end
    
end
