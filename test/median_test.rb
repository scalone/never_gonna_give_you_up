require File.dirname(File.realpath(__FILE__)) + "/test_helper.rb"

class TestMedian < Test::Unit::TestCase
  def setup
    @data_even = "5,4,8,8,7,6,6,8,8,12"
    @data_odd  =  "5,4,8,8,7,6,6,8,8"
    @data_odd2 = "3,4,3.5,5,3.5,4,5,5.5,4,5"
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

  #def test_median_odd_continous
    #data       = "111 90 121 105 122 61 128 112 128 93 108 138 88 110 112 112 97 128 102 125 87 119 104 116 96 114 107 113 80 113 123 95 115 70 115 101 114 127 92 103 78 118 100 115 116 98 119 72 125 109 79 139 75 109 123 124 108 125 116 83 94 106 117 82 122 99 124 84 91 130"
    #statistic  = Statistic.new(data)

    #statistic.to_table!(:continous)
    #statistic.print(:continous)
    #p statistic.total
    #p statistic.xiXfi_total

    #assert_equal [], @statistic_odd.median(:continous)
  #end
end
