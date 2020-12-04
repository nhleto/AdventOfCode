class Puzzle
  attr_accessor :map, :slope, :width, :height
  def initialize
    @map = File.readlines('slope.txt').join.split("\n").map(&:chars)
    @width = @map[0].length
    @height = @map.length
  end

  def direction
    p @map
    # direction_x, direction_y = [2][1]
  end

  def travel(y_slope, x_slope)
    x = 0
    y = 0
    trees = map[y][x] == '#' ? 1 : 0

    until y == @height - 1
      x += x_slope
      y += y_slope
      x -= @width if x > @width - 1
      trees += 1 if @map[y][x] == '#'
    end
    p trees
  end

  def slopes
    slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
    trees = slopes.map { |sqr| travel(sqr[1], sqr[0]) }
    p trees.reduce(&:*)
  end
end

puz = Puzzle.new
puz.slopes



