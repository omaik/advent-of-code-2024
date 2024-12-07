module Day6
  class Task
    DIRECTIONS = {
      up: '^',
      right: '>',
      down: 'v',
      left: '<'
    }.freeze

    def initialize(sample)
      @sample = sample
    end

    def call1
      @path = Set.new

      current_location, current_direction = cop_location

      @path << current_location

      loop do
        next_location = next_location(current_location, current_direction)
        if outside?(next_location)
          return @path.size
        elsif input.dig(*next_location) == '#'
          current_direction = next_direction(current_direction)
        else
          current_location = next_location
          @path << current_location
        end
      end
    end

    def call2
      @proven_cycles = Set.new
      call1
      counter = 0
      @path.each do |y, x|
        @cycle_path = Set.new

        next if input.dig(y, x) != '.'

        current_location, current_direction = cop_location

        @cycle_path << [current_location, current_direction]

        loop do
          next_location = next_location(current_location, current_direction)
          if outside?(next_location)
            break
          elsif @cycle_path.include?([next_location, current_direction])
            counter += 1
            break
          elsif input.dig(*next_location) == '#' || next_location == [y, x]
            current_direction = next_direction(current_direction)
          else
            current_location = next_location
          end

          @cycle_path << [current_location, current_direction]
        end
      end
      counter
    end

    def input
      @input ||= Input.call(@sample)
    end

    def cop_location
      input.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          direction = DIRECTIONS.invert[cell]
          return [[y, x], direction] if direction
        end
      end
    end

    def next_direction(direction)
      directions = DIRECTIONS.keys

      directions[(directions.index(direction) + 1) % directions.size]
    end

    def next_location(location, direction)
      case direction
      when :right
        [location[0], location[1] + 1]
      when :left
        [location[0], location[1] - 1]
      when :up
        [location[0] - 1, location[1]]
      when :down
        [location[0] + 1, location[1]]
      end
    end

    def outside?(location)
      (location[0]).negative? || (location[1]).negative? || location[0] >= input.size || location[1] >= input.first.size
    end
  end
end
