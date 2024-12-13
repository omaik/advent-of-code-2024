module Day13
  class Input
    class << self
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      def call(sample)
        data(sample).split("\n\n").map do |lines|
          button_a, button_b, destination = lines.split("\n")
          button_a = /: X\+(\d+), Y\+(\d+)/.match(button_a).captures.map(&:to_i)
          button_b = /: X\+(\d+), Y\+(\d+)/.match(button_b).captures.map(&:to_i)
          destination = /: X=(\d+), Y=(\d+)/.match(destination).captures.map(&:to_i)

          { a: button_a, b: button_b, destination: destination }
        end
      end

      def data(sample)
        sample ? File.read(SAMPLE_INPUT_FILE_PATH) : File.read(INPUT_FILE_PATH)
      end
    end
  end
end
