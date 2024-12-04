module Day4
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      counter = 0
      input.each.with_index do |line, y|
        line.each.with_index do |char, x|
          next unless char == 'X'

          counter += points_to_look(x, y).count do |points|
            points.map do |point|
              input.dig(*point.reverse)
            end == %w[M A S]
          end
        end
      end

      counter
    end

    def call2 # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      counter = 0
      input.each.with_index do |line, y|
        line.each.with_index do |char, x|
          next unless char == 'A'

          (counter += 1) if points_to_look2(x, y).all? do |points|
            points.flatten.all? { |p| !p.negative? } &&
            (%w[M S] - points.map do |point|
              input.dig(*point.reverse)
            end).empty?
          end
        end
      end

      counter
    end

    private

    def points_to_look(x, y)
      [
        [[x - 1, y - 1], [x - 2, y - 2], [x - 3, y - 3]],
        [[x, y - 1], [x, y - 2], [x, y - 3]],
        [[x + 1, y - 1], [x + 2, y - 2], [x + 3, y - 3]],
        [[x - 1, y], [x - 2, y], [x - 3, y]],
        [[x + 1, y], [x + 2, y], [x + 3, y]],
        [[x - 1, y + 1], [x - 2, y + 2], [x - 3, y + 3]],
        [[x, y + 1], [x, y + 2], [x, y + 3]],
        [[x + 1, y + 1], [x + 2, y + 2], [x + 3, y + 3]]
      ].map do |points|
        points.reject do |point|
          point.any?(&:negative?)
        end
      end
    end

    def points_to_look2(x, y)
      [
        [[x - 1, y - 1], [x + 1, y + 1]],
        [[x + 1, y - 1], [x - 1, y + 1]]
      ]
    end

    def input
      @input ||= Input.call(@sample)
    end
  end
end
