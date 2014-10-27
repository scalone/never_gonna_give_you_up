require './lib/table.rb'
require './lib/item_range.rb'
require './lib/item.rb'
require './lib/item_continuous.rb'
require './lib/item_discrete.rb'

class Statistic
  attr_accessor :table
  attr_reader :data, :values, :amplitude, :rol, :size, :k, :interval, :result, :total, :xiXfi_total

  DISTRIBUTION_TYPE_CONTINOUS = :continous
  DISTRIBUTION_TYPE_DISCRETE  = :discrete
  TYPE_MEDIAN                 = :median

  def self.create_from_table(type, objects)
    statistic = Statistic.new
    statistic.table = Table.create_from_itens(type, objects)
    statistic
  end

  def initialize(data=nil)
    unless data.nil?
      @data      = data
      @values, @total = Statistic::Parse.perform(data)
      @rol       = @values.sort
      @amplitude = calculate_amplitude
      @size      = @values.size.to_f
      @k         = calculate_k
      @interval  = calculate_interval(@amplitude, @k)
    end
  end

  def to_table!(type)
    create_table type
  end

  def create_table(type)
    @table = Table.new(type, self.rol, interval)
  end

  def calculate_amplitude
    (@rol.last - @rol.first).to_i.to_f # abs
  end

  def calculate_k
    Math.sqrt(@values.size).to_i.to_f # abs
  end

  def median(type = DISTRIBUTION_TYPE_DISCRETE)
    if type == DISTRIBUTION_TYPE_DISCRETE
      if (size % 2) == 0
        ((rol[(size / 2) - 1] + rol[size / 2])).to_f / 2
      else
        rol[(size + 1 / 2) - 1]
      end
    else # continous
    end
  end

  def mode
    group = Hash.new
    max   = 0

    rol.group_by{|v| v}.each do |k,v|
      group[v.size] ||= []
      group[v.size] << v.first
      max = v.size if max < v.size
    end

    group[max]
  end

  def average
    total/size
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
  def print_continous
    puts "\nindex -    range     -  FI   -  FR   -   F   -  FX"
    @table.itens.each_with_index do |item, index|
      display =  "#{(index+1).to_s.rjust(5, " ")} - "
      display << "#{item.range.to_s.rjust(12, " ")} - "
      display << "#{item.fi.to_s.rjust(5, " ")} - "
      display << "#{item.fr.round(2).to_s.rjust(5, " ")} - "
      display << "#{item.f.to_s.rjust(5, " ")} - "
      display << "#{item.fx.round(2).to_s.rjust(5, " ")}"
      puts display
    end
  end

  def print_discrete
    puts "\n   xi -  FI   -  FR  -    F  -   FX"
    @table.itens.sort_by(&:value).each do |v|
      puts "#{v.value.to_s.rjust(5, " ")} - #{v.fi.to_s.rjust(5, " ")} - #{v.fr.round(2).to_s.rjust(5, " ")} - #{v.f.to_s.rjust(5, " ")} - #{v.fx.round(2).to_s.rjust(5, " ")}"
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
      total = 0.0
      [list.collect{|v| total += v.strip.to_f; v.strip.to_f}, total]
    end
  end

end
