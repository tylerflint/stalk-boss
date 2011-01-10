require 'stalker'
require File.expand_path('../../lib/stalk_boss', __FILE__)

module StalkBoss
  def stock_jobs=(stock_jobs)
    @stock_jobs = stock_jobs if stock_jobs.is_a?(Array)
  end
end

include StalkBoss

describe StalkBoss, "#stock_job" do
  @worker = 'worker.rb'
  @log    = 'my_log.log'
  it "creates a stalk item with dsl" do
    stalk  = stalk_job(@worker, {:log => @log})
    stalk.is_a?(Stalk).should == true
  end
  it "properly sets stalk item worker" do
    stalk  = stalk_job(@worker, {:log => @log})
    stalk.worker.should == @worker
  end
  it "properly sets stalk item log" do
    worker = 'worker.rb'
    log    = 'my_log.log'
    stalk  = stalk_job(@worker, {:log => @log})
    stalk.log.should == @log
  end
  it "properly sets stalk item log with block" do
    stalk  = stalk_job(@worker) do |s| s.log = @log end
    stalk.log.should == @log
  end
end

describe StalkBoss, "#stock_jobs" do
  @worker = 'worker.rb'
  @log    = 'my_log.log'
  it "retains stalk items" do
    (1..10).each {|i| stalk_job("#{i}#{@worker}", {:log => "#{i}#{@log}"})}
    stalk_jobs.size.should == 10
  end
end

describe Stalker, "#soft_quit?" do
  it "has soft_quit? attribute" do
    Stalker.respond_to?('soft_quit?').should == true
  end
end