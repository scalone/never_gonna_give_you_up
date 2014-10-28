class Table
  TABLE_TYPE_CONTINOUS = :continous
  TABLE_TYPE_DISCRETE  = :discrete

  attr_accessor :itens, :rol, :index, :size, :type, :interval, :xifi

  def self.create_from_itens(type, objects)
    table = Table.new(type)
    table.size = objects.inject(0){|t,v| t+v[:fi]}
    objects.each do |item|
      table.itens << ItemContinuous.new(table, Array.new(item[:fi], item[:range].min), item[:range])
    end
    table
  end

  def initialize(type = TABLE_TYPE_DISCRETE, rol = [], interval = 0, itens = [])
    @rol      = rol
    @type     = type
    @itens    = itens
    @size     = rol.size.to_f
    @interval = interval
    @xifi     = 0
    populate!(rol) unless rol.empty?
  end

  def populate!(rol)
    if discrete?
      ItemDiscrete.create(self, rol)
    else
      ItemContinuous.create(self, rol, interval)
    end
  end

  def continous?
    self.type == TABLE_TYPE_CONTINOUS
  end

  def discrete?
    self.type == TABLE_TYPE_DISCRETE
  end
end

