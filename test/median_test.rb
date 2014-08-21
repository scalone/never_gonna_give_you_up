require File.dirname(File.realpath(__FILE__)) + "/test_helper.rb"

class TestMedian < Test::Unit::TestCase
  def setup
    @data_even = "5,4,8,8,7,6,6,8,8,12"
    @data_odd =  "5,4,8,8,7,6,6,8,8"
    @statistic_even = Statistic.new(@data_even)
    @statistic_odd  = Statistic.new(@data_odd)
  end

  def test_mode
    assert_equal [8], @statistic_even.mode
  end

  def test_average
    assert_equal 7.2, @statistic_even.average
  end

  def test_median_even
    assert_equal 7.5, @statistic_even.median
  end

  def test_median_odd
    assert_equal 8, @statistic_odd.median
  end
end
