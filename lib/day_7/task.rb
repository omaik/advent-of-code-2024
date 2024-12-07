module Day7
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      input.select do |line|
        ['*', '+'].repeated_permutation(line[:members].size - 1).any? do |operators|
          operators.each.with_index(1).inject(line[:members].first) do |sum, (operator, index)|
            sum.send(operator, line[:members][index])
          end == line[:sum]
        end
      end.pluck(:sum).sum
    end

    def call2
      input.select do |line|
        ['*', '+', '||'].repeated_permutation(line[:members].size - 1).any? do |operators|
          operators.each.with_index(1).inject(line[:members].first) do |sum, (operator, index)|
            break Float::INFINITY if sum > line[:sum]

            if operator == '||'
              "#{sum}#{line[:members][index]}".to_i
            else
              sum.send(operator, line[:members][index])
            end
          end == line[:sum]
        end
      end.pluck(:sum).sum
    end

    def input
      @input ||= Input.call(@sample)
    end
  end
end
