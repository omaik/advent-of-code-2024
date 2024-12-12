module Day12
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      clusters.map(&:last).flatten(1).map do |group|
        group.size * perimeter(group)
      end.sum
    end

    def call2
      clusters.map(&:last).flatten(1).map do |group|
        group.size * side_number(group)
      end.sum
    end

    def input
      @input ||= Input.call(@sample)
    end

    def clusters
      clusters = Hash.new { |h, k| h[k] = [] }
      input.each.with_index do |line, y|
        line.each.with_index do |el, x|
          clusters[el] << [y, x]
        end
      end

      clusters.map do |key, cluster|
        [key, run_separation(cluster)]
      end
    end

    def run_separation(cluster)
      return [] if cluster.empty?

      first = cluster.shift

      group1 = [first]

      loop do
        change_occured = false
        cluster.dup.each do |el|
          next unless neighbours(*el).any? { |neighbour| group1.include?(neighbour) }

          group1 << el
          cluster.delete(el)
          change_occured = true
        end

        break unless change_occured
      end

      [group1, *run_separation(cluster)]
    end

    def neighbours(y, x)
      [
        [y - 1, x],
        [y, x - 1],
        [y + 1, x],
        [y, x + 1]
      ]
    end

    def diagonal_neighbours(y, x)
      [
        [[y - 1, x - 1], [[y - 1, x], [y, x - 1]]],
        [[y - 1, x + 1], [[y - 1, x], [y, x + 1]]],
        [[y + 1, x - 1], [[y + 1, x], [y, x - 1]]],
        [[y + 1, x + 1], [[y + 1, x], [y, x + 1]]]
      ].reject { |loc, neighbours| outside?(loc) || neighbours.any? { |neighbour| outside?(neighbour) } }
    end

    def outside?(location)
      (location[0]).negative? || (location[1]).negative? || location[0] >= input.size || location[1] >= input.first.size
    end

    def perimeter(group)
      group.sum do |el|
        neighbours(*el).count do |neighbour|
          group.exclude?(neighbour)
        end
      end
    end

    def side_number(group) # rubocop:disable all
      return 4 if group.one?

      group.sum do |el|
        diag = diagonal_neighbours(*el).count do |diagonal_neighbour, neighbours|
          group.exclude?(diagonal_neighbour) &&
            neighbours.all? { |neighbour| group.include?(neighbour) }
        end
        res = neighbours(*el).cycle(2).each_cons(3).count do |neighbours|
          break 2 if neighbours.all? { |neighbour| group.exclude?(neighbour) }
        end

        next diag + res if res == 2

        res = neighbours(*el).cycle(2).each_cons(2).count do |neighbours|
          break 1 if neighbours.all? { |neighbour| group.exclude?(neighbour) }
        end

        next diag + res if res == 1

        diag
      end
    end
  end
end
