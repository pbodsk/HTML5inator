require 'rake/testtask'
task :default => [:run_tests]

desc "run all tests"
task :run_tests do
  Rake::TestTask.new("run_tests") do |test|  
      test.verbose = true
      test.warning = true
  end
end
