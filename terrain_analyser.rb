require_relative 'coordinate'
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
      while j != counter
        sub_terrain.push(data[j].to_i)
        j+=1
      end
      @terrain.push(sub_terrain)
    end
  end
  attr_reader :terrain
  attr_reader :min
  attr_reader :min_coordinates
  def minimum
    min = (2**(0.size*8 -2)-1)
    coord = Hash.new
    0.upto(@terrain.size-1) do |i|
      0.upto(@terrain[i].size-1) do |j|
        if min > @terrain[i][j]
          min = @terrain[i][j]
          coord[min] = Coordinate.new(min,i,j)
        end
      end
    end
    @min = min
    @min_coordinates = coord[min]
    @min_coordinates
  end

  def mean
    sum = 0.0
    cnt = 0
    @terrain.each_index do |i|
      column = @terrain[i]
      column.each_index do |j|
        sum+=@terrain[i][j]
        cnt+=1
      end
    end
    sum/cnt
  end

  def sd
    mu = mean()
    dist = 0.0
    cnt = 0
    @terrain.each_index do |i|
      column = @terrain[i]
      column.each_index do |j|
        dist += (@terrain[i][j] - mu)**2
        cnt+=1
      end
    end
    Math.sqrt(dist / cnt)
  end

  attr_reader :largest_pool
  def find_largest_pool
    @largest_pool = Pool.new(Coordinate.new(0,6,7),0,3,3)
  end
end

