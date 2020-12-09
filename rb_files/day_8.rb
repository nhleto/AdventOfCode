class Puzzle
  attr_accessor :sequence
  def initialize
    @sequence = File.read('../txt_files/day_8.txt')
  end

  # at what point is the accumulator value == 5
  def part_1
    p sequence.split("\n").join
  end
end

puz = Puzzle.new
puz.part_1
