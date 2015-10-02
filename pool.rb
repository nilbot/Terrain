require_relative 'coordinate'
class Pool
  @depth
  @width
  @height
  @starts_at
  @ends_at
  def initialize(leftmost, depth, m, n)
    @depth = depth
    @width = m
    @height = n
    @starts_at = leftmost
    @ends_at = Coordinate.new(leftmost.Value,leftmost.X + m - 1, leftmost.Y + n - 1)
  end
  attr_reader :depth
  attr_reader :width
  attr_reader :height
  attr_reader :starts_at
  attr_reader :ends_at
end