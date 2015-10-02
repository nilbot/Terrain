class Coordinate
  @X
  @Y
  @Value
  def initialize(value,x,y)
    @X = x
    @Y = y
    @Value = value
  end
  def to_s
    "#{@Value}. Occurs at (#{@X},#{@Y})."
  end

end