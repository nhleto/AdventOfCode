class Puzzle
  attr_accessor :customs
  def initialize
    @customs = File.read('../txt_files/customs.txt').split("\n\n")
  end

  def parser
    yes = 0
    customs.each do |codes|
      yes += codes.chars.uniq.reject { |n| n == "\n" }.count
    end
    p yes
  end

  def part_two
    yes = 0
    customs.map(&:split).each do |group|
      yes += group.map(&:chars).reduce(&:&).count
    end
    p yes
  end
end

puz = Puzzle.new
puz.part_two
