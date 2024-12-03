module Day3
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      multiply(input)
    end

    def call2
      dont_chunks = input.split("don't()")

      dos = [dont_chunks[0]]
      dos += dont_chunks[1..].flat_map do |r|
        r.split('do()')[1..]
      end

      dos.sum do |d|
        multiply(d)
      end
    end

    def multiply(string)
      string.scan(/mul\((\d{1,3}),(\d{1,3})\)/).sum do |l, r|
        l.to_i * r.to_i
      end
    end

    def input
      @input ||= Input.call(@sample)
    end
  end
end
