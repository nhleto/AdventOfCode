class Puzzle
  attr_accessor :input, :rows
  def initialize
    @input = File.read('../txt_files/boarding_pass.txt').split("\n")
    @rows = 127
  end

  def boarding_parse
    boarding_pass.each do |pass|
      pass[0] == 'F' ? front_plane_all << pass : back_plane_all << pass
    end
  end

  def finder(input, letter, arr)
    return arr.first if arr.length == 1

    if input[0] == letter
      finder(input[1..-1], letter, arr[0..((arr.length / 2) - 1)])
    else
      finder(input[1..-1], letter, arr[((arr.length / 2).floor)..-1])
    end
  end

  def output
    input.map do |bsp|
      finder(bsp[0..6], 'F', [*0..127]) * 8 + finder(bsp[7..9], 'L', [*0..7])
    end
  end

  def output_min
    p(*[*output.min..output.max] - output)
  end
end

puz = Puzzle.new
p puz.output_min
