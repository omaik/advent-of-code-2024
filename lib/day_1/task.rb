module Day1
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      left, right = input
      left.zip(right).sum do |l, r|
        (l - r).abs
      end
    end

    def call2
      left, right = input
      left.sum do |l|
        right.count(l) * l
      end
    end

    def input
      @input ||= Input.call(@sample)
    end
  end
end
