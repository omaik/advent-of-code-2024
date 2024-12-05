module Day5
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      rules, list = input

      correct_order = list.select do |line|
        sorted = line.sort do |a, b|
          if rules.include?([a, b])
            - 1
          elsif rules.include?([b, a])
            1
          else
            0
          end
        end

        sorted == line
      end

      correct_order.sum do |line|
        line[line.size / 2]
      end
    end

    def call2
      rules, list = input

      incorrect_ordered = list.map do |line|
        sorted = line.sort do |a, b|
          if rules.include?([a, b])
            - 1
          elsif rules.include?([b, a])
            1
          else
            0
          end
        end

        sorted == line ? nil : sorted
      end.compact

      incorrect_ordered.sum do |line|
        line[line.size / 2]
      end
    end

    def input
      @input ||= Input.call(@sample)
    end
  end
end
