class Statistic
  attr_reader :data, :values, :amplitude, :rol, :size, :k, :interval, :result, :total

  DISTRIBUTION_TYPE_CONTINOUS = :continous
  DISTRIBUTION_TYPE_DISCRETE  = :discrete
  TABLE_SCHEME = {
    :range  => nil,
    :F      => 0.0,
    :fr     => 0.0,
    :fx     => 0.0,
    :values => []
  }

  def initialize(data)
    @data      = data
    @values    = parse(data)
    @rol       = @values.sort
    @amplitude = @rol.last - @rol.first
    @size      = @values.size
    @k         = Math.sqrt(@values.size).to_i
    @interval  = calculate_interval(@amplitude, @k)
  end

  def to_table!(type)
    if type == DISTRIBUTION_TYPE_DISCRETE
      @result = to_discrete
    elsif type == DISTRIBUTION_TYPE_CONTINOUS
      @result = to_continous
    else
      raise "Invalid type"
    end

    @result.delete(0)
    @result
  end

  def to_continous
    index = 0
    group = {0 => TABLE_SCHEME}
    rol.each do |value|
      if ! @range || ! @range.include?(value)
        index += 1
        group[index] = Hash.new

        if @last
          @range = @last..(@last + interval - 1)
          @last  = (@last + interval)
        else
          @range = value..(value + interval - 1)
          @last  = (value + interval)
        end
        group[index][:range] = @range
        group[index][:values] = rol.select do |v|
          @range.include? v
        end
        populate_line(group, index, size)
      end
    end
    group
  end

  def to_discrete
    index = 0
    group = {0 => TABLE_SCHEME}
    rol.group_by {|v| v}.each do |k,v|
      index += 1
      group[index] ||= Hash.new
      group[index][:values] = v
      group[index][:value]  = v.first
      populate_line(group, index, size)
    end
    group
  end

  def print(type)
    p self.rol
    if type == DISTRIBUTION_TYPE_DISCRETE
      print_discrete
    elsif type == DISTRIBUTION_TYPE_CONTINOUS
      print_continous
    else
      raise "Invalid type"
    end
  end

  private
  def print_continous
    puts "\nindex -  range   -  FI   -  FR   -   F   -  FX"
    @result.sort_by{|k,v| k}.each do |k, v|
      puts "#{k.to_s.rjust(5, " ")} - #{fix_range(v[:range]).to_s.rjust(8, " ")} - #{v[:fi].to_s.rjust(5, " ")} - #{v[:fr].round(2).to_s.rjust(5, " ")} - #{v[:F].to_s.rjust(5, " ")} - #{v[:fx].round(2).to_s.rjust(5, " ")}"
    end
  end

  def fix_range(range)
    range.min..(range.max + 1)
  end

  def print_discrete
    puts "\n   xi - FI  -  FR  -    F  -   FX"
    @result.sort_by{|k,v| k}.each do |k, v|
      puts "#{v[:value].to_s.rjust(5, " ")} - #{v[:fi].to_s.rjust(2, " ")} - #{v[:fr].round(2).to_s.rjust(5, " ")} - #{v[:F].to_s.rjust(5, " ")} - #{v[:fx].round(2).to_s.rjust(5, " ")}"
    end
  end

  def populate_line(group, index, number_of_elements)
    group[index][:fi] = group[index][:values].size
    group[index][:fr] = (100.0 * group[index][:fi] / number_of_elements)
    group[index][:F]  = (group[index-1][:F]  + group[index][:fi])
    group[index][:fx] = (group[index-1][:fx] + group[index][:fr])
  end

  # TODO Remove exception
  def parse(data)
    begin
      if @data.include? ","
        return convert(@data.split(","))
      elsif @data.include? " "
        return convert(@data.split(" "))
      end
    end

    raise "Use coma or coma + space to separate values"
  end

  def convert(list)
    @total = 0.0
    list.collect{|v| @total += v.strip.to_c; v.strip.to_c}
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
end
