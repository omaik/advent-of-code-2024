module Day1
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      left, right = input
      left.zip(right).map do |l, r|
        (l - r).abs
      end.sum
    end

    def call2
      left, right = input
      left.map do |l|
        right.count(l) * l
      end.sum
    end

    def input
      @input ||= Input.call(@sample)
    end
  end
end
