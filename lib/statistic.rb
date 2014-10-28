require './lib/table.rb'
require './lib/item_range.rb'
require './lib/item.rb'
require './lib/item_continuous.rb'
require './lib/item_discrete.rb'

class Statistic
  attr_accessor :table
  attr_reader :data, :values, :amplitude, :rol, :k, :interval, :result, :type

  DISTRIBUTION_TYPE_CONTINOUS = :continuous
  DISTRIBUTION_TYPE_DISCRETE  = :discrete

  def self.create_from_table(type, objects)
    # Only for continuous now
    statistic = Statistic.new(type)
    statistic.table = Table.create_from_itens(type, objects)
    statistic
  end

  def initialize(type = DISTRIBUTION_TYPE_DISCRETE, data=nil)
    @type = type
    unless data.nil?
      @data      = data
      @values    = Statistic::Parse.perform(data)
      @rol       = @values.sort
      @amplitude = calculate_amplitude
      @k         = calculate_k
      @interval  = calculate_interval(@amplitude, @k)
    end
  end

  def to_table!
    create_table self.type
  end

  def create_table(type)
    @table = Table.new(type, self.rol, interval)
  end

  def calculate_amplitude
    (@rol.last - @rol.first).to_i.to_f # abs
  end

  def calculate_k
    Math.sqrt(size).to_i.to_f # abs
  end

  def median
    if self.type == DISTRIBUTION_TYPE_DISCRETE
      if (size % 2) == 0
        ((rol[(size / 2) - 1] + rol[size / 2])).to_f / 2
      else
        rol[(size + 1 / 2) - 1]
      end
    else # continous
    end
  end

  def mode
    if self.type == DISTRIBUTION_TYPE_DISCRETE
      group = Hash.new
      max   = 0

      rol.group_by{|v| v}.each do |k,v|
        group[v.size] ||= []
        group[v.size] << v.first
        max = v.size if max < v.size
      end

      group[max]
    else
    end
  end

  def average
    xifi / size
  end

  def xifi
    self.table.xifi
  end

  def size
    self.table.size
  end

  def print(type)
    if type == DISTRIBUTION_TYPE_DISCRETE
      print_discrete
    elsif type == DISTRIBUTION_TYPE_CONTINOUS
      print_continous
    elsif type == TYPE_MEDIAN
      print_median
    else
      raise "Invalid type"
    end
  end

  private
  def print_continuous
    puts "\nindex -    range     -  FI   -  FR   -   F   -  FX   -  xifi"
    @table.itens.each_with_index do |item, index|
      display =  "#{(index+1).to_s.rjust(5, " ")} - "
      display << "#{item.range.to_s.rjust(12, " ")} - "
      display << "#{item.fi.to_s.rjust(5, " ")} - "
      display << "#{item.fr.round(2).to_s.rjust(5, " ")} - "
      display << "#{item.f.to_s.rjust(5, " ")} - "
      display << "#{item.fx.round(2).to_s.rjust(5, " ")} - "
      display << "#{item.xifi.round(2).to_s.rjust(6, " ")}"
      puts display
    end
  end

  def print_discrete
    puts "\n   xi -  FI   -  FR  -    F  -   FX   -  xifi"
    @table.itens.sort_by(&:value).each do |v|
      display =  "#{v.value.to_s.rjust(5, " ")} "
      display << "#{v.fi.to_s.rjust(5, " ")} - "
      display << "#{v.fr.round(2).to_s.rjust(5, " ")} - "
      display << "#{v.f.to_s.rjust(5, " ")} - "
      display << "#{v.fx.round(2).to_s.rjust(5, " ")} - "
      display << "#{v.fx.round(2).to_s.rjust(6, " ")}"
      puts display
    end
  end

  def print_median
    puts "Median: #{self.median}; Mode: #{self.mode}; Average: #{self.average}"
  end

  def calculate_interval(amp, k)
    new_amp, new_k = number_of_classes(amp, k)
    new_amp/new_k
  end

  def number_of_classes(amp, k)
    loop do
      amp += 1
      if (amp % k == 0)
        return [amp, k]
      elsif (amp % (k + 1)) == 0
        return [amp, k + 1]
      elsif (amp % (k - 1)) == 0
        return [amp, k - 1]
      end
    end
  end

  class Parse
    def self.perform(data)
      begin
        if data.include? ","
          return convert(data.split(","))
        elsif data.include? " "
          return convert(data.split(" "))
        end
      end

      raise "Use coma or coma + space to separate values"
    end

    def self.convert(list)
      list.collect{|v| v.strip.to_f}
    end
  end

end
