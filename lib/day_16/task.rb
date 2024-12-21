module Day16
  class Task
    DIRECTIONS = %i[north east south west].freeze

    def initialize(sample)
      @sample = sample
    end

    def call1
      start = find_point('S')
      ending = find_point('E')

      @costs = Hash.new { |h, k| h[k] = Float::INFINITY }

      stack = [[start, :east, 0]]

      loop do
        break if stack.empty?

        point, direction, steps = stack.pop

        moves = moves(point, direction)

        moves.each do |move, new_direction, adding_cost|
          new_cost = steps + adding_cost
          next if @costs[[move, new_direction]] <= new_cost

          index = stack.index { |s| distance_to_end(s.first, ending) > distance_to_end(move, ending) } || -1

          stack.insert(index, [move, new_direction, new_cost])
          @costs[[move, new_direction]] = new_cost
        end
      end

      DIRECTIONS.map do |direction|
        @costs[[ending, direction]]
      end.min
    end

    def call2
      start = find_point('S')
      ending = find_point('E')

      @costs = Hash.new { |h, k| h[k] = Float::INFINITY }
      @finishes = []

      stack = [[start, :east, 0, [start]]]

      loop do
        break if stack.empty?

        point, direction, steps, path = stack.pop

        @finishes << [steps, path] if point == ending

        moves = moves(point, direction)

        moves.each do |move, new_direction, adding_cost|
          new_cost = steps + adding_cost
          next if @costs[[move, new_direction]] < new_cost

          index = stack.index { |s| distance_to_end(s.first, ending) > distance_to_end(move, ending) } || -1

          stack.insert(index, [move, new_direction, new_cost, path + [move]])
          @costs[[move, new_direction]] = new_cost
        end
      end

      min_cost = DIRECTIONS.map do |direction|
        @costs[[ending, direction]]
      end.min

      @finishes.select { |x| x[0] == min_cost }.map(&:last).flatten(1).uniq.size
    end

    def distance_to_end(point, ending)
      (point[0] - ending[0]).abs + (point[1] - ending[1]).abs
    end

    def find_point(char)
      input.each_with_index do |line, y|
        index = line.index(char)

        return [y, index] if index
      end
    end

    def input
      @input ||= Input.call(@sample)
    end

    def moves(point, direction)
      direction_index = DIRECTIONS.index(direction)

      next_point = next_step(point, direction)
      steps = [
        [point, DIRECTIONS[(direction_index + 1) % 4], 1000],
        [point, DIRECTIONS[(direction_index - 1) % 4], 1000]

      ]
      steps << [next_point, direction, 1] if input[next_point[0]][next_point[1]] != '#'

      steps
    end

    def next_step(point, direction)
      case direction
      when :north
        [point[0] - 1, point[1]]
      when :south
        [point[0] + 1, point[1]]
      when :east
        [point[0], point[1] + 1]
      when :west
        [point[0], point[1] - 1]
      end
    end
  end
end
