class Bag
  @list = []
  attr_accessor :style, :color

  class << self
    def find(style, color)
      @list.find { |bag| (bag.style == style && bag.color == color) }
    end

    def all
      @list
    end

    def clear
      @list = []
    end

    def all_as_string
      @list.map { |bag| "#{bag.style} #{bag.color}" }
    end

    def find_or_create(style, color)
      return find(style, color) if find(style, color)

      bag = new(style, color)
      @list << bag
      puts "created #{style} #{color}"
      bag
    end

    def from_string(rule_string)
      outside, inside = rule_string.split('bags contain')

      style, color = outside.split
      bag = Bag.find_or_create(style, color)

      inside_definitions = inside.split(',')
      inside_definitions.map do |combo|
        amount, style, color = combo.split
        amount.to_i.times do
          bag.should_contain << Bag.find_or_create(style, color)
        end
      end
      bag
    end
  end

  def initialize(style, color)
    @style = style
    @color = color
    @should_contain = []
  end

  def should_contain(deep: false)
    return @should_contain unless deep

    @should_contain + @should_contain.map { |bag| bag.should_contain(deep: true) }.flatten
  end

  def will_contain?(bag)
    return true if @should_contain.uniq.include?(bag)

    @should_contain.uniq.any? { |b| b.will_contain?(bag) }
  end

  def to_s
    "#{@style} #{@color}"
  end
end

Bag.clear

bag_rules = File.readlines("../txt_files/rules.txt")
bag_rules.each do |rule|
  Bag.from_string( rule )
end
puts "Solution 1"

count = Bag.all.count do |bag|
  bag.will_contain?(Bag.find("shiny", "gold"))
end

puts count


puts "Solution 2"

puts Bag.find("shiny", "gold").should_contain(deep: true).count