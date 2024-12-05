module Day5
  class Input
    class << self
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      def call(sample)
        rules, list = data(sample).split("\n\n")

        rules = rules.split("\n").map do |line|
          line.split('|').map(&:to_i)
        end

        list = list.split("\n").map do |line|
          line.split(',').map(&:to_i)
        end
        [rules, list]
      end

      def data(sample)
        sample ? File.read(SAMPLE_INPUT_FILE_PATH) : File.read(INPUT_FILE_PATH)
      end
    end
  end
end
