require 'test/unit'
require_relative 'TerrainAnalyser'
class TerrainAnalyserTest < Test::Unit::TestCase
  def setup
    test_trivial_file = File.open('terrain.dat','w')
    test_trivial = %q{10
6 1 3 4 5 0 7 3 1 9
8 1 3 4 5 9 7 2 9 2
3 2 8 4 5 1 7 1 6 3
1 9 3 4 5 6 7 9 5 3
2 7 4 4 5 2 7 0 2 1
6 2 9 4 5 7 7 7 3 2
9 5 1 4 5 3 7 0 0 0
6 2 3 4 5 5 7 0 0 0
1 2 2 4 5 7 7 0 0 0
1 2 8 4 5 9 7 4 5 8
}
    test_trivial_file.puts(test_trivial)
    test_trivial_file.close
    @ta = TerrainAnalyser.new
  end

  def test_initialize
    assert_equal(10, @ta.terrain.length, 'init failed, array differ in length')
  end

  def test_find_lowest
    assert_equal(0,@ta.get_valley, "expected 0, but got #{@ta.get_valley}")
  end
end