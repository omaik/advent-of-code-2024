module Day14
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      input.map do |robot|
        robot.quadrant(*space, 100)
      end.reject(&:zero?).group_by(&:itself).transform_values(&:size).values.inject(:*)
    end

    def call2
      @min_q = Float::INFINITY
      step_num = 0
      0.upto(10_000) do |steps|
        q = input.map do |robot|
          robot.quadrant(*space, steps)
        end.reject(&:zero?).group_by(&:itself).transform_values(&:size).values.inject(:*)

        next unless q < @min_q

        @min_q = q
        step_num = steps

        p steps
        print_canvas(steps)
      end
      step_num
    end

    def input
      @input ||= Input.call(@sample)
    end

    def print_canvas(steps)
      positions = input.map { |robot| robot.position(*space, steps) }
      positions.map(&:first).group_by(&:itself).transform_values(&:size).values.max
      # return if size < 5
      # return

      0.upto(space.last - 1) do |y|
        puts(0.upto(space.first - 1).map do |x|
          positions.include?([x, y]) ? '#' : '.'
        end.join)
        # puts
      end
    end

    def space
      @sample ? [11, 7] : [101, 103]
    end
  end
end
