
# lista 1 exec 1
#@values = [111, 90, 121, 105, 122, 61, 128, 112, 128, 93, 108, 138, 88, 110, 112, 112, 97, 128, 102, 125, 87, 119, 104, 116, 96, 114, 107, 113, 80, 113, 123, 95, 115, 70, 115, 101, 114, 127, 92, 103, 78, 118, 100, 115, 116, 98, 119, 72, 125, 109, 79, 139, 75, 109, 123, 124, 108, 125, 116, 83, 94, 106, 117, 82, 122, 99, 124, 84, 91, 130]

# lista 1 exec 2
#@values = [28, 6, 17, 48, 63, 47, 27, 21, 3, 7, 12, 39, 50, 54, 33, 45, 15, 24, 1, 7, 36, 53, 46, 27, 5, 10, 32, 50, 52, 11, 42, 22, 3, 17, 34, 56, 25, 2, 30, 10, 33, 1, 49, 13, 16, 8, 31, 21, 6, 9, 2, 11, 32, 25, 0, 55, 23, 41, 29, 4, 51, 1, 6, 31, 5, 5, 11, 4, 10, 26, 12, 6, 16, 8, 2, 4, 28]

# lista 1 exec 3
#@values = [18, 26, 21, 24, 26, 18, 19, 21, 18, 21, 24, 26, 28, 26, 21, 18, 19, 21, 21, 20, 21, 22, 18, 19, 21, 22, 18, 19, 21, 19]
@type = :disc

# ROL
puts "ROL"
p @values.sort!

# Amplitude
@amplitude = @values.last - @values.first

# Number of classes
@number_elements = @values.size
@k = Math.sqrt(@number_elements).to_i

def n_classes
  loop do
    @amplitude += 1
    if (@amplitude % @k == 0)
      return [@amplitude, @k]
    elsif (@amplitude % (@k + 1)) == 0
      return [@amplitude, @k + 1]
    elsif (@amplitude % (@k - 1)) == 0
      return [@amplitude, @k + 1]
    end
  end
end

def generate_group
  @group[@i][:fi] = @group[@i][:values].size
  @group[@i][:fr] =  100.0 * @group[@i][:fi] / @number_elements
  @group[@i][:F] = @group[@i-1][:F] + @group[@i][:fi]
  @group[@i][:fx] = @group[@i-1][:fx] + @group[@i][:fr]
end

# Interval
@ac, @k = n_classes
@interval = @ac/@k

# Table
@group = Hash.new

@group[0] = {:F => 0.0, :fr => 0.0, :fx => 0.0} # To calculate Total
@i = 0
@last = nil

if @type == :keep
  @values.each do |v|
    if ! @range || ! @range.include?(v)
      @i += 1
      @group[@i] = Hash.new

      if @last
        @range = @last..(@last + @interval - 1)
        @last  = (@last + @interval)
      else
        @range = v..(v + @interval -1)
        @last  = (v + @interval)
      end
      @group[@i][:range] = @range

      @group[@i][:values] = @values.select do |value|
        @range.include? value
      end

      generate_group
    end
  end
else
  @disc = @values.group_by {|v| v}
  @disc.each do |(k,v)|
    @i += 1
  @group[@i] = Hash.new
  @group[@i][:values] = v
  generate_group
  end
end

# Continua
puts "\nindex -  range   -  FI   -  FR   -   F   -  FX"
@group.sort_by{|k,v| k}.each do |k, v|
  if v[:range]
    puts "#{k.to_s.rjust(5, " ")} - #{v[:range].to_s.rjust(8, " ")} - #{v[:fi].to_s.rjust(5, " ")} - #{v[:fr].round(2).to_s.rjust(5, " ")} - #{v[:F].to_s.rjust(5, " ")} - #{v[:fx].round(2).to_s.rjust(5, " ")}"
  end
end

# Discreta
puts "\n   xi - FI  -  FR  -    F  -   FX"
@group.sort_by{|k,v| k}.each do |k, v|
  if v[:fi]
    puts "#{k.to_s.rjust(5, " ")} - #{v[:fi].to_s.rjust(2, " ")} - #{v[:fr].round(2).to_s.rjust(5, " ")} - #{v[:F].to_s.rjust(5, " ")} - #{v[:fx].round(2).to_s.rjust(5, " ")}"
  end
end


