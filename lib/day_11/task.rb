module Day11
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      simulate(25)
    end

    def call2
      simulate(75)
    end

    def simulate(steps)
      @cache = Hash.new { |h, k| h[k] = 0 }

      input.each do |el|
        @cache[el] += 1
      end

      steps.times do
        new_cache = Hash.new { |h, k| h[k] = 0 }

        @cache.each do |k, v|
          run_rules(k).each do |el|
            new_cache[el] += v
          end
        end

        @cache = new_cache
      end

      @cache.values.sum
    end

    def input
      @input ||= Input.call(@sample)
    end

    def run_rules(el)
      if el.zero?
        [1]
      elsif el.to_s.chars.size.even?
        split(el)
      else
        [el * 2024]
      end
    end

    def split(el)
      chars = el.to_s.chars
      [chars[0...chars.size / 2].join.to_i, chars[chars.size / 2..].join.to_i]
    end
  end
end
