class TerrainAnalyser
  def initialize
    @terrain = []
    counter = -1
    IO.foreach('terrain.dat') do |line|
      if counter == -1
        counter = line.to_i
        next
      end
      data = line.split
      j = 0
      sub_terrain = []
      while j != counter - 1
        sub_terrain.push(data[j].to_i)
        j+=1
      end
      @terrain.push(sub_terrain)
    end
  end
  attr_reader :terrain
  def minimum
    min = (2**(0.size * 8 -2) -1) # min := max_int
    @terrain.each_index do |i|
      subarray = @terrain[i]
      subarray.each_index do |j|
        min = @terrain[i][j] if min > @terrain[i][j]
      end
    end
    min
  end
end

