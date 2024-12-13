module Day13
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      input.map do |game|
        find_tokens(game, 100)
      end.compact.sum.to_i
    end

    def call2
      input.each do |game|
        game[:destination][0] += 10_000_000_000_000
        game[:destination][1] += 10_000_000_000_000
      end

      input.map do |game|
        find_tokens(game)
      end.compact.sum.to_i
    end

    def input
      @input ||= Input.call(@sample)
    end

    def find_tokens(game, limit = Float::INFINITY)
      a, b, destination = game.values_at(:a, :b, :destination)
      a1 = a[0]
      b1 = b[0]
      c1 = destination[0]
      d1 = a[1]
      e1 = b[1]
      f1 = destination[1]

      y = (c1 * d1 - a1 * f1).fdiv(b1 * d1 - a1 * e1)
      x = (c1 - b1 * y).fdiv(a1)

      return nil unless (y % 1).zero? && (x % 1).zero?
      return nil if x > limit || y > limit

      x * 3 + y
    end
  end
end
