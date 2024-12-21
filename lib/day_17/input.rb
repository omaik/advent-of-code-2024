module Day17
  class Input
    class << self
      INPUT_FILE_PATH = "#{__dir__}/input.txt".freeze
      SAMPLE_INPUT_FILE_PATH = "#{__dir__}/input.sample.txt".freeze

      def call(sample)
        registers, instructions = data(sample).split("\n\n")

        Program.new(registers, instructions)
      end

      def data(sample)
        sample ? File.read(SAMPLE_INPUT_FILE_PATH) : File.read(INPUT_FILE_PATH)
      end
    end

    class Program
      def initialize(registers, instructions)
        @a, @b, @c = registers.scan(/\d+/).map(&:to_i)
        @instructions = instructions.scan(/\d/).map(&:to_i)
        @pointer = 0
        @output = []
      end

      attr_accessor :a, :pointer, :instructions, :output

      def execute
        loop do
          break if @pointer >= @instructions.size

          # p [@a, @b, @c, @pointer, @instructions[@pointer, 2]]  if rand(1000) == 3

          execute_step
        end

        @output
      end

      def execute_step
        command, operand = @instructions[@pointer, 2]

        @pointer += 2

        case command
        when 0
          @a /= (2**operand_to_value(operand))
        when 1
          @b ^= operand
        when 2
          b_before
          @b = operand_to_value(operand) % 8
        when 3
          @pointer = operand if @a.nonzero?
        when 4
          @b ^= @c
        when 5
          # binding.pry
          p ['output', @a, @b, operand_to_value(operand) % 8]
          @output << operand_to_value(operand) % 8
        when 6
          @b = @a / (2**operand_to_value(operand))
          p ['writing b', @a, @b, @c, operand_to_value(operand)]
        when 7
          @c = @a / (2**operand_to_value(operand))
        end
      end

      def operand_to_value(operand)
        case operand
        when 0, 1, 2, 3
          operand
        when 4
          @a
        when 5
          @b
        when 6
          @c
        when 7
          raise 'Invalid operand'
        end
      end
    end
  end
end
