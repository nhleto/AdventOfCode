class Puzzle
  attr_accessor :input
  def initialize
    @input = File.read('expense.txt').split.map(&:to_i)
    @data = File.read('passwords.txt').split("\n")
  end

  def expenses
    input.each do |i|
      input.each do |j|
        input.each do |f|
          sum = i + j + f
          next unless sum == 2020

          puts i, j, f
          puts i * j * f
          exit
        end
      end
    end
  end

  def password
    passwords = []
    nums = 0
    @data.each do |item|
      key, value = item.split(':')
      quantity, letter = key.split(' ')
      passwords << (min = quantity.split('-').first.to_i, max = quantity.split('-').last.to_i, letter, value.strip)
    end
    passwords.each do |min, max, letter, value|
      nums += 1 if value.count(letter).between?(min, max)
    end
    passwords_part_2(passwords)
    # nums
  end

  def passwords_part_2(passwords)
    nums = 0
    passwords.each do |min, max, letter, value|
      nums += 1 if value.chars[min - 1] == letter && value.chars[max - 1] != letter || value.chars[max - 1] == letter && value.chars[min - 1] != letter
    end
    p nums
  end
end

puz = Puzzle.new
puz.password
