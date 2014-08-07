require 'rake/testtask'
require './lib/statistic.rb'

Rake::TestTask.new do |t|
  t.libs << "lib"
  t.test_files = FileList['test/*test.rb']
  t.verbose = true
end


namespace :statistic do
  #rake statistic:calculate TYPE=discrete VALUES=111,90,121,105,122,61,128,112,128,93,108,138,88,110,112,112,97,128,102,125,87,119,104,116,96,114,107,113,80,113,123,95,115,70,115,101,114,127,92,103,78,118,100,115,116,98,119,72,125,109,79,139,75,109,123,124,108,125,116,83,94,106,117,82,122,99,124,84,91,130
  desc "Statistic Calculate"
  task :calculate do
    statistic = Statistic.new(ENV["VALUES"])
    statistic.to_table!(ENV["TYPE"].to_sym)
    statistic.print(ENV["TYPE"].to_sym)
  end
end
