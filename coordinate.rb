class Coordinate
  @X
  @Y
  @Value
  attr_reader :X
  attr_reader :Y
  attr_reader :Value
  def initialize(value,x,y)
    @X = x
    @Y = y
    @Value = value
  end
  def to_s
    "#{@Value}. Occurs at (#{@X},#{@Y})."
  end
  def ==(other)
    @X == other.X && @Y == other.Y && @Value == other.Value
  end
end