require_relative '../lib/utils/runner'
require 'test/unit'

class TestRunner < Test::Unit::TestCase
  def setup
    argv = ["-u", "http://peterbodskov.dk"]
    @runner = Utils::Runner.new(argv)
  end


  def test_can_create_runner
    refute_nil(@runner)
    refute_nil(@runner.commands)
    refute_nil(@runner.report_generator)
    assert_equal(4, @runner.commands.length)
  end
  
  def test_can_run
    @runner.run
    output = @runner.report_generator.generate_html
    refute_nil(/text\/javascript/ =~ output)
    refute_nil(/text\/css/ =~ output)
  end
end