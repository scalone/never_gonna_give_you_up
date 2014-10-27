class ItemRange
  PRECISION = 0.0000001
  attr_accessor :range, :interval, :numbers

  def initialize(numbers, interval)
    @interval = interval
    @numbers  = numbers
    @range    = (numbers.first)..(numbers.first + interval)
  end

  def next(value)
    unless in? value
      @range = (range.max)..(range.max + interval)
    end
    @range
  end

  def in?(value)
    # need to not read end value
    # wrong response for this logic
    # (1..10).include? 10 => true
    # right response for this logic
    # (1..10).include? 10 => false
    # similar to:
    # (1..9.9999999).include? 10 => false
    tmp_range = (range.min..(range.max - PRECISION))
    tmp_range.include? value
  end
end
