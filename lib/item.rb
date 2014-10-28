class Item
  # f = F
  # xi - number in the collection
  # fi - number of times you have the number
  # fr - frequence related with the number
  # fx - percentage acumulation
  # f  - Acumullation of number
  attr_accessor :before, :values, :value, :table, :f, :fr, :fr, :fi, :fx, :xifi
  DEFAULT = Struct.new(:before, :f, :fx, :xifi)

  def initialize(table, values)
    @table  = table
    @value  = values.first
    @values = values
    @before = get_before
    set_values
  end

  def set_values
    @fi   = values.size.to_f
    @fr   = 100.0 * @fi / self.table.size
    @f    = self.before.f + self.fi
    @fx   = self.before.fx + self.fr
    @xifi = set_xifi
  end

  def set_xifi
    xi_fi = calculate_xifi
    self.table.xifi += xi_fi
    xi_fi
  end

  def klass
    (self.table.itens.index self) + 1
  end

  private

  def get_before
    self.table.itens.last || DEFAULT.new(nil, 0.0, 0.0, 0.0)
  end
end
