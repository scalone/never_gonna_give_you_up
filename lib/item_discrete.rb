class ItemDiscrete < Item
  def self.create(table, rol)
    rol.group_by {|v| v}.each do |number, numbers|
      table.itens << ItemDiscrete.new(table, numbers)
    end
  end
end
