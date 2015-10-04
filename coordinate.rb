class Coordinate
  @x
  @y
  @value
  attr_reader :x
  attr_reader :y
  attr_reader :value
  def initialize(value,x,y)
    @x = x
    @y = y
    @value = value
  end
  def to_s
    "#{@value}. Occurs at (#{@x},#{@y})."
  end
  def ==(other)
    @x == other.x && @y == other.y && @value == other.value
  end
end