class Puzzle
  attr_accessor :map, :slope, :width, :height, :passports
  def initialize
    @map = File.readlines('slope.txt').join.split("\n").map(&:chars)
    @passports = File.open('passports.txt').read
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

  # def passport_parser
  #   pass = []
  #   pass_array = []
  #   valid_passports = 0
  #   second_consideration = []
  #   string_pass = []
  #   fields = %w[byr iyr eyr hgt hcl ecl pid]
  #   passports.split(/\n{2,}/).each { |p| pass << p }
  #   pass.each_slice(1).to_a.each do |p|
  #     pass_array << p.join.split(' ')
  #   end
  #   pass_array.each { |passp| string_pass << passp.join }
  #   string_pass.each do |sub_pass|
  #     second_consideration << sub_pass if fields.all? { |key| sub_pass.include?(key) }
  #   end
  #   secondary_parser(second_consideration)
  # end

  def passport_parser
    final = []
    fields = %w[byr iyr eyr hgt hcl ecl pid]
    passports.split(/\n{2,}/).each do |pass|
      final << pass if fields.all? { |key| pass.include?(key) }
    end
    tertiary_parser(final)
  end

  def tertiary_parser(final_passports)
    pass_array = []
    valid_pasport1 = []
    valid_pasport2 = []
    valid_pasport3 = []
    valid_pasport4 = []
    valid_pasport5 = []
    valid_pasport6 = []
    valid_pasport7 = []

    final_passports.each { |pass| pass_array << pass.split(' ') }
    pass_array.each do |pass|
      valid_pasport1 << pass if valid_birth_year(pass.find { |passp| passp.include?('byr') })
    end
    valid_pasport1.each do |pass|
      valid_pasport2 << pass if valid_issue_year(pass.find { |passp| passp.include?('iyr') })
    end
    valid_pasport2.each do |pass|
      valid_pasport3 << pass if valid_expiration_year(pass.find { |passp| passp.include?('eyr') })
    end
    valid_pasport3.each do |pass|
      valid_pasport4 << pass if valid_height(pass.find { |passp| passp.include?('hgt') })
    end
    valid_pasport4.each do |pass|
      valid_pasport5 << pass if valid_hair_color(pass.find { |passp| passp.include?('hcl') })
    end
    valid_pasport5.each do |pass|
      valid_pasport6 << pass if valid_eye_color(pass.find { |passp| passp.include?('ecl') })
    end
    valid_pasport6.each do |pass|
      valid_pasport7 << pass if valid_passport_id(pass.find { |passp| passp.include?('pid') })
    end
    p valid_pasport7.count
  end

  def valid_birth_year(input)
    p input[/\d+/].to_i.between?(1920, 2002)
  end

  def valid_issue_year(input)
    input[/\d+/].to_i.between?(2010, 2020)
  end

  def valid_expiration_year(input)
    input[/\d+/].to_i.between?(2020, 2030)
  end

  def valid_height(input)
    if input.include?('cm')
      input[/\d+/].to_i.between?(150, 193)
    else
      input[/\d+/].to_i.between?(59, 76)
    end
  end

  def valid_hair_color(input)
    input[/#[a-z0-9]{6}/]
  end

  def valid_eye_color(input)
    color = %w[amb blu brn gry grn hzl oth]
    color.any? { |color| color == input.split(':').last }
  end

  def valid_passport_id(input)
    input[/\d+/].length == 9
  end
end

puz = Puzzle.new
puz.passport_parser
