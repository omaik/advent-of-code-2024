module Day9
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      accum = []
      input.each_slice(2).with_index do |(present, empty), index|
        accum.concat([index] * present)
        accum.concat([nil] * empty)
      end
      accum.size.times do |i|
        next if accum[i]

        accum.pop while accum[-1].nil?

        accum[i] = accum.pop
      end

      accum.compact.map.with_index do |el, index|
        el * index
      end.sum
    end

    def call2 # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
      accum = []
      input.each_slice(2).with_index do |(present, empty), index|
        accum << [index] * present
        accum << [nil] * empty
      end

      ii = 0

      loop do
        index = accum.index.with_index { |x, i| i >= ii && x.size.positive? && x.first.nil? }
        break unless index

        slots = accum[index].size
        els = []

        while slots.positive?
          el = accum[(index + 1)..].reverse.detect { |x| !x.first.nil? && x.size <= slots }
          unless el
            ii = index + 1
            break
          end

          el_index = accum.index(el)
          accum[el_index] = [nil] * el.size
          slots -= el.size
          els.concat(el)
        end

        accum[index] = els + [nil] * slots
      end

      accum.flatten.map.with_index do |el, index|
        el.to_i * index
      end.sum
    end

    def input
      @input ||= Input.call(@sample)
    end
  end
end
