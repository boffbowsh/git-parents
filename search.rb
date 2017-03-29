#!/usr/bin/env ruby

require 'bundler/setup'
require 'rugged'

THRESHOLD = Time.now - 365*24*60*60

repo = Rugged::Repository.new(ARGV[0])

walker = Rugged::Walker.new(repo)
walker.push 'HEAD'

walker.each do |commit|
  next if commit.time < THRESHOLD
  if commit.parents.size == 2 && commit.parents.all? { |p| p.parent_ids.size == 1 }
    puts "\n\n======"
    puts commit.oid
    puts commit.message

    puts "\n\nParent 1:"
    puts "#{commit.parents[0].oid} #{commit.parents[0].committer[:name]}"
    puts commit.parents[0].message.split("\n")[0..4].join("\n")

    puts "\n\nParent 2:"
    puts "#{commit.parents[1].oid} #{commit.parents[1].committer[:name]}"
    puts commit.parents[1].message.split("\n")[0..4].join("\n")
  end
end
