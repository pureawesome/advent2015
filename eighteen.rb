@grid = File.readlines('eighteen.txt')
            .map(&:strip)
            .map { |line| line.split('').map { |item| item == '#' ? 1 : 0 } }
            .flatten

@side = 100

def coord_to_index(x, y)
  (x * @side) + y
end

def index_to_coord(index)
  x = index / @side
  y = index % @side
  [x, y]
end

def get_neighbors(x, y)
  n_array = []
  (x - 1..x + 1).each do |coord1|
    next if coord1 < 0 || coord1 >= @side
    (y - 1..y + 1).each do |coord2|
      next if coord2 < 0 || coord2 >= @side
      next if coord1 == x && coord2 == y
      n_array.push([coord1, coord2])
    end
  end
  n_array
end

def update_state(state, neighbors)
  if state == 1
    (neighbors == 2 || neighbors == 3) ? 1 : 0
  else
    neighbors == 3 ? 1 : 0
  end
end

def run_test_animation
  @side.times do
    new_grid = @grid.map.with_index do |light, index|
      coord = index_to_coord(index)
      total = get_neighbors(coord[0], coord[1]).map { |arr| @grid[coord_to_index(arr[0], arr[1])] }.inject(:+)
      update_state(light, total)
    end
    @grid = new_grid
  end
end

run_test_animation
p @grid.inject(:+)
