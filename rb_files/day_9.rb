class Puzzle
  attr_accessor :input, :preamble
  def initialize
    @input = File.read('../txt_files/day_9.txt').split("\n").map(&:to_i)
  end

  def part_1
    p d = input[25..-1].select.with_index { |n, i| input[i..i + 24].none? { |k| input[i..i + 24].include?(n - k) } }.first
    p (4..input.count).each { |s| input.each_cons(s) { |a| return p (a.min+a.max) if a.reduce(:+) == d } }

  end
end

puz = Puzzle.new
puz.part_1
