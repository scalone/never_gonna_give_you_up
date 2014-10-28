require 'rake/testtask'
require './lib/statistic.rb'

Rake::TestTask.new do |t|
  t.libs << "lib"
  t.test_files = FileList['test/*test.rb']
  t.verbose = true
end

namespace :statistic do
  desc "Statistic Calculate"
  task :calculate do
    statistic = Statistic.new(ENV["TYPE"].to_sym, ENV["VALUES"])
    statistic.to_table! unless ENV["TYPE"].to_sym == :median
    statistic.print
  end
end

namespace :list1 do
  desc "Exercise 1"
  task :e1 do
    statistic = Statistic.new(Statistic::DISTRIBUTION_TYPE_CONTINOUS, "111,90,121,105,122,61,128,112,128,93,108,138,88,110,112,112,97,128,102,125,87,119,104,116,96,114,107,113,80,113,123,95,115,70,115,101,114,127,92,103,78,118,100,115,116,98,119,72,125,109,79,139,75,109,123,124,108,125,116,83,94,106,117,82,122,99,124,84,91,130")
    statistic.to_table!
    p statistic.rol
    statistic.print
  end

  desc "Exercise 2"
  task :e2 do
    statistic = Statistic.new(Statistic::DISTRIBUTION_TYPE_CONTINOUS", 28 06 17 48 63 47 27 21 03 07 12 39 50 54 33 45 15 24 01 07 36 53 46 27 05 10 32 50 52 11 42 22 03 17 34 56 25 02 30 10 33 01 49 13 16 08 31 21 06 09 02 11 32 25 0 55 23 41 29 04 51 01 06 31 05 05 11 04 10 26 12 06 16 08 02 04 28")
    statistic.to_table!
    p statistic.rol
    statistic.print
  end

  desc "Exercise 3"
  task :e3 do
    statistic = Statistic.new(Statistic::DISTRIBUTION_TYPE_CONTINOUS, "18     26    21     24     26     18     19     21     18     21    24     26     28    26    21    18     19      21     21    20     21     22      18    19     21     22    18    19      21    19")
    statistic.to_table!
    statistic.print
  end
end

namespace :list11 do
  desc "Exercise 1"
  task :e1 do
    statistic = Statistic.new(Statistic::DISTRIBUTION_TYPE_DISCRETE, "6  9 2 7 0 8 2 5 4 2 5  4 4 4 4 2 5 6 3 7 3  8 8 4 4 4 7 7 6 5 4  7 5 3 3 1 3 8 0 6 5  1 2 3 3 0 5 6 6 3")
    statistic.to_table!
    statistic.print
  end

  desc "Exercise 2"
  task :e2 do
    statistic = Statistic.new(Statistic::DISTRIBUTION_TYPE_DISCRETE, "50   50   52   52   52   52   52   52   54  53  53   53   53   53   53  51  51   51   51   51")
    statistic.to_table!
    statistic.print
  end

  desc "Exercise 3"
  task :e3 do
    statistic = Statistic.new(Statistic::DISTRIBUTION_TYPE_DISCRETE, "2  0  0  4  3  0  0  1  0  0  1  1  2  1  1  1  1  1  1  0  0  0  3  0  0  0  2  0  0  1 1  2  0  2  0  0  0  0  0  0  0  0  0  0  0  0  1  0")
    statistic.to_table!
    statistic.print
  end

  desc "Exercise 4"
  task :e4 do
    itens = [
      {:range => 150..180, :fi =>  3},
      {:range => 180..210, :fi =>  8},
      {:range => 210..240, :fi => 10},
      {:range => 240..270, :fi => 13},
      {:range => 270..300, :fi => 33},
      {:range => 300..330, :fi => 40},
      {:range => 330..360, :fi => 35},
      {:range => 360..390, :fi => 30},
      {:range => 390..420, :fi => 16},
      {:range => 420..450, :fi => 12}
    ]

    statistic = Statistic.create_from_table(Statistic::DISTRIBUTION_TYPE_CONTINOUS, itens)
    statistic.print
  end

  desc "Exercise 5"
  task :e5 do
    statistic = Statistic.new(Statistic::DISTRIBUTION_TYPE_DISCRETE, "0 1 0 1 0 0 0 0 2 3 0 1 2 3 4 0 0 0 1 4 1 1 0 0 3 5 1 0 0 1")
    statistic.to_table!
    statistic.print
  end

  desc "Exercise 6"
  task :e6 do
    statistic = Statistic.new(Statistic::DISTRIBUTION_TYPE_CONTINOUS, "32  40  22  11  34  40  16  26  23  31  27  10  38  17  13 45  25  10  18  23  35  22  30  14  18  20  13  24  35  29 33  48  20  12  31  39  17  58  19  16  12  21  15  12  20 51  12  19  15  41  29  25  13  23  32  14  27  43  37  21 28  37  26  44  11  53  38  46  17  36  28  49  56  19  11")
    statistic.to_table!
    statistic.print
  end
end

namespace :list3 do
  desc "Exercise 1"
  task :e1 do
    statistic = Statistic.new(Statistic::DISTRIBUTION_TYPE_CONTINOUS, "3 4 3.5 5 3.5 4 5 5.5 4 5")
    p statistic.rol
    statistic.print(true)
  end

  desc "Exercise 2"
  task :e2 do
    statistic = Statistic.new(Statistic::DISTRIBUTION_TYPE_DISCRETE, "18, 17, 19, 17, 18, 18, 20, 18, 18, 18, 19, 18, 21, 18, 20, 18, 20, 18, 18, 19, 18, 19, 19, 19, 18, 19, 19, 21, 19, 19, 19, 21, 17, 19, 19, 18, 19, 19, 18, 20, 20, 18, 20, 18, 20, 20, 19, 19, 21, 18")
    puts "A: Rol \n\n#{statistic.rol}\n\n"
    puts "B: tabela discreta"
    statistic.to_table!
    statistic.print
    puts "\nC: Moda, Média e Mediana e suas interpretações\n\n"
    statistic.print(true)
  end

  desc "Exercise 3"
  task :e3 do
    itens = [
      {:range =>   0..50, :fi => 10},
      {:range => 50..100, :fi => 28},
      {:range =>100..150, :fi => 12},
      {:range =>150..200, :fi =>  2},
      {:range =>200..250, :fi =>  1},
      {:range =>250..300, :fi =>  1}
    ]

    statistic = Statistic.create_from_table(Statistic::DISTRIBUTION_TYPE_CONTINOUS, itens)
    statistic.print
    statistic.print(true)
  end

  desc "Exercise 3"
  task :e4 do
    itens = [
      {:range =>   3..6, :fi => 2},
      {:range =>   6..9, :fi => 5},
      {:range =>  9..12, :fi => 8},
      {:range => 12..15, :fi => 3},
      {:range => 15..18, :fi => 1}
    ]

    statistic = Statistic.create_from_table(Statistic::DISTRIBUTION_TYPE_CONTINOUS, itens)
    statistic.print
    statistic.print(true)
  end

  desc "Exercise 10"
  task :e10 do
    #TODO Scalone CONTINUAR AKI
    statistic = Statistic.new("3, 4, 3.5, 5, 3.5, 4, 5, 5.5, 4, 5")
    statistic.to_table!(:discrete)
    statistic.print(:discrete)
  end
end

