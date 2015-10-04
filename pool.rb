require_relative 'coordinate'
class Pool
  include Comparable
  @depth
  @dimension
  @starts_at
  @ends_at
  def initialize(leftmost, depth, dim)
    @depth = depth
    @dimension = dim
    @starts_at = leftmost
    @ends_at = Coordinate.new(leftmost.value,leftmost.x + dim - 1, leftmost.y + dim - 1)
  end
  attr_reader :depth
  attr_reader :dimension
  attr_reader :starts_at
  attr_reader :ends_at
  def <=>(other)
    if @dimension < other.dimension
      -1
    elsif @dimension > other.dimension
      1
    elsif @dimension == other.dimension # we want small depth
      if @depth < other.depth
        1
      elsif @depth > other.depth
        -1
      elsif @depth == other.depth
        0
      end
    end
  end
  def to_s
    "at (#{@starts_at.x}, #{@starts_at.y}) there's a #{@dimension}x#{@dimension} pool of height #{@depth}."
  end
end