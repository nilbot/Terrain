class MaxHeap

  @tree # array : binary tree with a dummy head

  def initialize(arr=[])
    @tree = []
    @tree.push(:dummy_head)
    0.upto(arr.size-1) do |i|
      push(arr[i])
    end
  end

  def push(object)
    @tree.push(object)
    sift_up(@tree.size-1)
  end

  def pop()
    head = @tree[1]
    to_sift_down = @tree.pop()
    @tree[1] = to_sift_down
    sift_down(1)
    head
  end

  def peek()
    @tree[1]
  end


  private

  def swap(first_index,second_index)
    temp = @tree[first_index]
    @tree[first_index] = @tree[second_index]
    @tree[second_index] = temp
  end

  def sift_down(index)
    left = 2*index
    right = 2*index+1
    largest = index
    if left <= @tree.size-1 && @tree[left] > @tree[largest]
      largest = left
    end
    if right <= @tree.size-1 && @tree[right] > @tree[largest]
      largest = right
    end

    if largest != index
      swap(index, largest)
      sift_down(largest)
    end
  end

  def sift_up(index)
    father = index/2
    if father > 0 && @tree[index] > @tree[father]
      swap(index, father)
      sift_up(father)
    end
  end
end