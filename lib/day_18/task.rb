module Day18
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      find_path(obstacles_limit)
    end

    def call2
      l = obstacles_limit
      h = input.size

      while l < h
        mid = (l + h) / 2
        if find_path(mid) < Float::INFINITY
          l = mid + 1
        else
          h = mid
        end
      end

      input[l - 1]
    end

    def find_path(limit)
      stack = [[[0, 0], 0]]

      @nodes_cost = Hash.new { |h, k| h[k] = Float::INFINITY }

      obstacles = input.first(limit)

      loop do
        break if stack.empty?

        point, steps = stack.pop

        moves = moves(point) - obstacles

        moves.each do |move|
          next unless @nodes_cost[move] > steps + 1

          index = stack.index { |s| s.first.map(&:abs).sum - s.last > move.map(&:abs).sum - steps + 1 } || -1
          stack.insert(index, [move, steps + 1])
          @nodes_cost[move] = steps + 1
        end
      end
      @nodes_cost[endpoint]
    end

    def map_size
      @sample ? 6 : 70
    end

    def endpoint
      @sample ? [6, 6] : [70, 70]
    end

    def input
      @input ||= Input.call(@sample)
    end

    def obstacles_limit
      @sample ? 12 : 1024
    end

    def moves(point)
      [
        [point[0] - 1, point[1]],
        [point[0] + 1, point[1]],
        [point[0], point[1] - 1],
        [point[0], point[1] + 1]
      ].reject do |move|
        move.any? { |coord| coord.negative? || coord > map_size }
      end
    end
  end
end
