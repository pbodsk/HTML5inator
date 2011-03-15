require_relative '../lib/utils/options_parser'
require 'test/unit'

class TestDoctypeCommand < Test::Unit::TestCase
  def test_can_create_options_parser
    argv = ["-u", "http://peterbodskov.dk"]
    options_parser = Utils::OptionsParser.new(argv)
    refute_nil(options_parser)
  end
end