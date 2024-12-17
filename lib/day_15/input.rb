module Day15
  class Input
    class << self
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      def call(sample)
        map, moves = data(sample).split("\n\n")

        map = map.split("\n").map { |line| line.split('') }
        moves = moves.split('').compact_blank

        [map, moves]
      end

      def data(sample)
        sample ? File.read(SAMPLE_INPUT_FILE_PATH) : File.read(INPUT_FILE_PATH)
      end
    end
  end
end
