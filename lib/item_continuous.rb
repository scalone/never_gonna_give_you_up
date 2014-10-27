class ItemContinuous < Item
  attr_accessor :range

  def initialize(table, values, range)
    @range = range
    super(table, values)
  end

  def self.create(table, rol, interval)
    range = ItemRange.new(rol, interval)
    group = rol.group_by do |value|
      range.next(value)
    end
    group.each do |range, values|
      table.itens << ItemContinuous.new(table, values, range)
    end
  end
end
