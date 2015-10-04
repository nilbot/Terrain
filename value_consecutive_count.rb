class ValueConsecutiveCount
  @value
  @height
  @count
  attr_reader :value
  attr_reader :height
  attr_accessor :count
  def initialize(v,c)
    @value = v
    @height = c
    @count = c
  end
end