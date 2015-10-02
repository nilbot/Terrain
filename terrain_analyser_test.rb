require 'test/unit'
require_relative 'terrain_analyser'
require_relative 'coordinate'
require_relative 'pool'
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
    assert_equal(10, @ta.terrain.length, 'init failed, array row differ in length')
    assert_equal(10, @ta.terrain[0].length, 'init failed, array col differ in length')
  end

  def test_find_lowest
    @ta.minimum
    assert_equal(0,@ta.min, "expected 0, but got #{@ta.min}")
    assert_equal(Coordinate.new(0,0,5),@ta.min_coordinates,"expected 0 at (0,5), but got #{@ta.min_coordinates}")
  end

  def test_find_average
    assert_equal(4.14,@ta.mean, "expected 4.14, but got #{@ta.mean}")
  end

  def test_std
    assert_equal(2.731373280970581, @ta.sd, "expected 2.731373280970581, but got #{@ta.sd}")
  end

  def test_find_largest_pool
    rect = [
        Coordinate.new(0,6,7),
        Coordinate.new(0,8,9)
    ]
    expect = []
    expect[0] = rect
    expect[1] = 0
    width = 3
    height = 3
    @ta.find_largest_pool
    assert_equal(width, @ta.largest_pool.width, "expected width = 3, but was #{@ta.largest_pool.width}")
    assert_equal(height, @ta.largest_pool.height, "expected height = 3, but was #{@ta.largest_pool.height}")
    assert_equal(expect[1],@ta.largest_pool.depth, "expected depth = 0, but was #{@ta.largest_pool.depth}")
    assert_equal(expect[0][0],@ta.largest_pool.starts_at, "expected starts at (6,7), but was #{@ta.largest_pool.starts_at}")
    assert_equal(expect[0][1],@ta.largest_pool.ends_at, "expected ends at (8,9), but was #{@ta.largest_pool.ends_at}")
  end
end