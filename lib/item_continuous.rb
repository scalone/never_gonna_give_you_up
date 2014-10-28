class ItemContinuous < Item
  attr_accessor :range

  def self.create(table, rol, interval)
    range = ItemRange.new(rol, interval)
    group = rol.group_by do |value|
      range.next(value)
    end
    group.each do |range, values|
      table.itens << ItemContinuous.new(table, values, range)
    end
  end

  def initialize(table, values, range)
    @range = range
    super(table, values)
  end

  def calculate_xifi
    average_min_max = (self.range.min + self.range.max) / 2
    average_min_max * self.fi
  end
end
