class Statistic
  attr_reader :data, :values, :amplitude, :rol, :size, :k, :interval

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

  def to_table(type)
    if type == DISTRIBUTION_TYPE_DISCRETE
      group = to_discrete
    elsif type == DISTRIBUTION_TYPE_CONTINOUS
      group = to_continous
    else
      raise "Invalid type"
    end

    group.delete(0)
    group
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
      group[index] = Hash.new
      group[index][:values] = v
      populate_line(group, index, size)
    end
    group
  end

  private
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
    list.collect{|v| v.strip.to_i}
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
        return [amp, k + 1]
      end
    end
  end
end
