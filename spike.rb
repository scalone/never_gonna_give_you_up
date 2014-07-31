
@values = [111, 90, 121, 105, 122, 61, 128, 112, 128, 93, 108, 138, 88, 110, 112, 112, 97, 128, 102, 125, 87, 119, 104, 116, 96, 114, 107, 113, 80, 113, 123, 95, 115, 70, 115, 101, 114, 127, 92, 103, 78, 118, 100, 115, 116, 98, 119, 72, 125, 109, 79, 139, 75, 109, 123, 124, 108, 125, 116, 83, 94, 106, 117, 82, 122, 99, 124, 84, 91, 130]

# ROL
p @values.sort!

# Amplitude
@amplitude = @values.last - @values.first

# Número de classes

@number_elements = @values.size
@k = Math.sqrt(@number_elements).to_i

def n_classes(amp, k)
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

# Intervalo de Classe
@ac, @k = n_classes(@amplitude, @k)
@interval = @ac/@k

# Tabela
@group = Hash.new

@group[0] = {:F => 0.0, :fr => 0.0, :fx => 0.0} # To calculate Total
@i = 0
@last = nil

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

    @group[@i][:fi] = @group[@i][:values].size
    @group[@i][:fr] =  100.0 * @group[@i][:fi] / @number_elements
    @group[@i][:F] = @group[@i-1][:F] + @group[@i][:fi]
    @group[@i][:fx] = @group[@i-1][:fx] + @group[@i][:fr]
  end
end

puts "index -  range   -  FI   -  FR   -   F   -  FX"
@group.sort_by{|k,v| k}.each do |k, v|
  if v[:range]
    puts "#{k.to_s.rjust(5, " ")} - #{v[:range].to_s.rjust(8, " ")} - #{v[:fi].to_s.rjust(5, " ")} - #{v[:fr].round(2).to_s.rjust(5, " ")} - #{v[:F].to_s.rjust(5, " ")} - #{v[:fx].round(2).to_s.rjust(5, " ")}"
  end
end