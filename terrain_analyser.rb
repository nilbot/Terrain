require_relative 'coordinate'
require_relative 'value_consecutive_count'
require_relative 'max_heap'
require_relative 'pool'
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
    min = (2**(0.size*8-2)-1)
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
    # @largest_pool = Pool.new(Coordinate.new(0,6,7),0,3)
    @largest_pool = largest_pool_by_histogram
  end

  private
  def largest_pool_by_histogram
    # scan through NxN -> O(n) once
    # first scan gains us the information of (value, consecutive_count) at (i,j)
    aux_array = []
    last_value = -1
    last_count = 1
    n = @terrain.size-1
    0.upto(n) { |i|
      sub_array = []
      0.upto(n) { |j|
        value = @terrain[i][j]
        if last_value == value
          last_count+=1
        else
          # if last_value != value
          last_count = 1
          last_value = value
        end
        sub_array.push(ValueConsecutiveCount.new(value,last_count))
      }
      aux_array.push(sub_array)
    }

    # scan through aux_array by column, scan from top to bottom of counts that
    # is not 1, and see if they connect; i.e: to qualify a 2x2 pool, the scan
    # needs to see (i,j) with count 2 and (i+1,j) with count 2 && they share
    # the same value. The check must also not rule out ascending check_tasks.
    # Basically, the check simulates the largest area in histogram challenge
    # from <a href="http://www.informatik.uni-ulm.de/acm/Locals/2003/html/histogram.html">ACM 2003</a>.
    # Only we need squares rather than all rectangles. So it should be easier.
    # Amortised O(n) because each element will at most be added once to job stack.
    # The qualified pool anchor is then at (i-count+1,j-count+1), with dimension=count.
    # Qualified pool is then pushed into a max heap
    max_heap = MaxHeap.new
    best_so_far = 1 # best pool so far
    0.upto(n) {
      |j|
      jobs = []
      0.upto(n) {
        |i|
        vc = aux_array[i][j]
          work_load = jobs.count
          pointer = 0
          1.upto(work_load) {
            job = jobs[pointer]
            if job.value == vc.value
              if job.height <= vc.height # include plateau and hill climbing
                job.count-=1
                if job.count == 1
                  # qualified a pool with job.height
                  qualified_pool = Pool.new(Coordinate.new(job.value,i-job.height+1,j-job.height+1),job.value,job.height)
                  max_heap.push(qualified_pool)
                  best_so_far = max_heap.peek.dimension if !max_heap.peek.equal?(nil)
                  # finished remove this job from the queue, pointer remains
                  jobs.shift()
                else
                  pointer+=1 # proceed to next job
                end
              else # job.height > vc.height
                # directly ignore and remove this job because it serves no one
                jobs.shift()
              end
            else
              jobs.shift() # value not equal, remove and next
            end
          }
        jobs.push(vc) if vc.height!=1 && best_so_far <= vc.height
      }
    }
    # O(n) + O(n) = O(n)
    max_heap.pop()
  end
end

