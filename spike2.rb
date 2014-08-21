# Exec 1
#values = [3, 4, 3.5, 5, 3.5, 4, 5, 5.5, 4, 5]

# Exec 2
#values = [18, 17, 19, 17, 18, 18, 20, 18, 18, 18, 19, 18, 21, 18, 20, 18, 20, 18, 18, 19, 18, 19, 19, 19, 18, 19, 19, 21, 19, 19, 19, 21, 17, 19, 19, 18, 19, 19, 18, 20, 20, 18, 20, 18, 20, 20, 19, 19, 21, 18]

# Exec 3
#values = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 5, 5, 5, 5]

# Exec 9
# Verificar, talvez esteja errado
#values = [6, 7, 9, 10, 12, 14, 15, 15, 15, 16, 16, 17, 18, 18, 18, 18, 19, 19, 20, 20, 20, 20, 21, 21, 21, 22, 22, 23, 24, 25, 25, 26, 26, 28, 28, 30, 32, 32, 35, 39]

# Exec 10
values = [5, 4, 8, 8, 7, 6, 6, 8, 8, 12]
# media 7,2 mo 8, md 7,5

result = values.inject(0){|r,v| r+v}

# media
puts "X #{result.to_f/values.size}"
puts values.size

p values.sort

# moda
def get_collection(values)
  values.group_by{|v| v}
end

def get_mo(collection)
  r = Hash.new
  b = 0
  collection.each do |k,v|
    r[v.size] ||= []
    r[v.size] << v.first
    b = v.size if b < v.size
  end

  r[b]
end

puts "Mo #{get_mo(get_collection(values))}"

def get_md(values)
  values = values.sort
  size = values.size
  if (size % 2) == 0
    ((values[(size / 2) - 1] + values[size / 2])).to_f / 2
  else
    values[(size + 1 / 2) - 1]
  end
end

puts "Md #{get_md(values)}"
