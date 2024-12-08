module Day8
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      detect_antennas.combination(2).each.with_object(Set.new) do |((y1, x1), (y2, x2)), points|
        next if value(y1, x1) != value(y2, x2)

        y = y1 - y2
        x = x1 - x2

        p1 = [y1 - 2 * y, x1 - 2 * x]
        p2 = [y2 + 2 * y, x2 + 2 * x]

        points << p1 unless outside?(p1)
        points << p2 unless outside?(p2)
      end.size
    end

    def call2
      detect_antennas.combination(2).each.with_object(Set.new) do |((y1, x1), (y2, x2)), points|
        next if value(y1, x1) != value(y2, x2)

        y = y1 - y2
        x = x1 - x2

        -50.upto(50).each do |i|
          p1 = [y1 - i * y, x1 - i * x]
          p2 = [y2 + i * y, x2 + i * x]

          points << p1 unless outside?(p1)
          points << p2 unless outside?(p2)
        end
      end.size
    end

    def input
      @input ||= Input.call(@sample)
    end

    def value(y, x)
      input.dig(y, x)
    end

    def detect_antennas
      input.each.with_index.with_object([]) do |(line, y), antennas|
        line.each.with_index do |point, x|
          next if point == '.'

          antennas << [y, x]
        end
      end
    end

    def outside?(location)
      (location[0]).negative? || (location[1]).negative? || location[0] >= input.size || location[1] >= input.first.size
    end
  end
end
