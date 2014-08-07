
require "./statistic.rb"
require "./test/fixture.rb"
require "test/unit"

class TestStatistic < Test::Unit::TestCase
  def setup
    @data_space = "111 90 121 105 122 61 128 112 128 93 108 138 88 110 112 112 97 128 102 125 87 119 104 116 96 114 107 113 80 113 123 95 115 70 115 101 114 127 92 103 78 118 100 115 116 98 119 72 125 109 79 139 75 109 123 124 108 125 116 83 94 106 117 82 122 99 124 84 91 130"
    @data_coma  = "111, 90, 121, 105, 122, 61, 128, 112, 128, 93, 108, 138, 88, 110, 112, 112, 97, 128, 102, 125, 87, 119, 104, 116, 96, 114, 107, 113, 80, 113, 123, 95, 115, 70, 115, 101, 114, 127, 92, 103, 78, 118, 100, 115, 116, 98, 119, 72, 125, 109, 79, 139, 75, 109, 123, 124, 108, 125, 116, 83, 94, 106, 117, 82, 122, 99, 124, 84, 91, 130"
    @values     = @data_space.split(" ").collect(&:to_i)
    @statistic  = Statistic.new(@data_coma)
  end

  def test_att_reader_data
    assert_equal @data_coma, @statistic.data
  end

  def test_parse_data_wrong
    #assert_raise_with_message RuntimeError, "Use coma or coma + space to separate values" do
    assert_raise RuntimeError do
      Statistic.new("123123-1231-12312-123123-123123-123")
    end
  end

  def test_parse_data_coma
    assert_equal @values, @statistic.values
  end

  def test_parse_data_white_space
    assert_equal @values, Statistic.new(@data_space).values
  end

  def test_data_rol
    assert_equal @values.sort, @statistic.rol
  end

  def test_amplitude
    rol = @values.sort
    amplitude = rol.last - rol.first
    assert_equal amplitude, @statistic.amplitude
  end

  def test_number_of_elemets
    assert_equal @values.size, @statistic.size
  end

  def test_number_of_classes
    assert_equal Math.sqrt(@values.size).to_i, @statistic.k
  end

  def test_interval
    assert_equal 10, @statistic.interval
  end

  # TODO fragment or abstract this
  def test_to_table_continous
    assert_equal Fixture::CONTINOUS_TABLE, @statistic.to_table!(:continous)
    assert_equal Fixture::CONTINOUS_TABLE, @statistic.result
  end

  # TODO fragment or abstract this
  def test_to_table_discrete
    assert_equal Fixture::DISCRETE_TABLE, @statistic.to_table!(:discrete)
    assert_equal Fixture::DISCRETE_TABLE, @statistic.result
  end
end