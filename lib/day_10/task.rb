module Day10
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      locations = find_zeros

      @count_of_trails = 0
      @count_of_paths = 0

      locations.each do |location|
        @heights = Set.new
        traverse(location)
        @count_of_trails += @heights.size
      end
      @count_of_trails
    end

    def call2
      locations = find_zeros

      @count_of_paths = 0

      locations.each do |location|
        @heights = Set.new
        traverse(location)
      end
      @count_of_paths
    end

    def input
      @input ||= Input.call(@sample)
    end

    def traverse(location)
      neighbours(location).each do |neighbour|
        next unless (value(*neighbour) - value(*location)) == 1

        if value(*neighbour) == 9
          @count_of_paths += 1
          @heights << neighbour
        end

        traverse(neighbour)
      end
    end

    def find_zeros
      input.each.with_index.with_object([]) do |(line, y), zeros|
        line.each.with_index do |point, x|
          zeros << [y, x] if point.zero?
        end
      end
    end

    def outside?(location)
      (location[0]).negative? || (location[1]).negative? || location[0] >= input.size || location[1] >= input.first.size
    end

    def value(y, x)
      input.dig(y, x)
    end

    def neighbours(location)
      [
        [location[0] - 1, location[1]],
        [location[0] + 1, location[1]],
        [location[0], location[1] - 1],
        [location[0], location[1] + 1]
      ].reject { |loc| outside?(loc) }
    end
  end
end
