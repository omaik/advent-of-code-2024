module Day14
  class Input
    class << self
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      def call(sample)
        data(sample).split("\n").map do |line|
          Robot.new(line)
        end
      end

      def data(sample)
        sample ? File.read(SAMPLE_INPUT_FILE_PATH) : File.read(INPUT_FILE_PATH)
      end
    end
  end

  class Robot
    def initialize(line)
      @line = line

      @position_x, @position_y, @speed_x, @speed_y = line.match(/p=(.+),(.+) v=(.+),(.+)/).captures.map(&:to_i)
    end

    def position(x_limit, y_limit, steps)
      new_x = @position_x + @speed_x * steps
      new_y = @position_y + @speed_y * steps

      new_x %= x_limit
      new_x = x_limit + new_x if new_x.negative?

      new_y %= y_limit
      new_y = y_limit + new_y if new_y.negative?

      [new_x, new_y]
    end

    def quadrant(x_limit, y_limit, steps)
      new_x, new_y = position(x_limit, y_limit, steps)

      if new_x < x_limit / 2 && new_y < y_limit / 2
        1
      elsif new_x > x_limit / 2 && new_y < y_limit / 2
        2
      elsif new_x < x_limit / 2 && new_y > y_limit / 2
        3
      elsif new_x > x_limit / 2 && new_y > y_limit / 2
        4
      else
        0
      end
    end
  end
end
