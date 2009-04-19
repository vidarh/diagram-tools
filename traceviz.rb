#!/bin/env ruby

# See http://www.hokstad.com/traceviz-visualizing-traceroute-output-with-graphivz.html

require 'timeout'
require 'set'
require 'socket'

TRACEROUTE=`which traceroute`.chomp
TIMES=3
TIMEOUT=60

def traceroute host
  `#{TRACEROUTE} -n #{host}`
end


class TraceViz
  def initialize(times,timeout)
    @times,@timeout = times,timeout
    @edges = Set.new
    @nodes = Set.new
    @targets = Set.new
    @this_host = Socket.gethostname
    @targets << @this_host
  end

  def trace host
    @times.times do |i|
      STDERR.puts "Trace ##{i+1} for #{host}"
      Timeout::timeout(@timeout) do
        process_trace(host,traceroute(host))
      end rescue nil
    end
  end

  def process_trace host,trace
    @targets << host
    trace = [@this_host] + trace.collect do |line| 
      line=line.split
      line[0].to_i > 0 && line[1] != "*" ? line[1] : nil
    end.compact
    trace << host
    trace.each {|h| @nodes << h }
    trace.each_cons(2) {|h1,h2| @edges << [h1,h2] }
  end

  def to_dot
    res = "digraph G {"
    @edges.each { |h1,h2| res << "   \"#{h1}\"->\"#{h2}\"\n" }
    @nodes.each do |n| 
      color = @targets.member?(n) ? "lightblue" : "lightgrey"
      res << "  \"#{n}\" [style=filled fillcolor=#{color}]\n"
    end
    res << "}"
  end
end

tv = TraceViz.new(TIMES,TIMEOUT)
ARGV.each {|host| tv.trace(host) }
puts tv.to_dot

