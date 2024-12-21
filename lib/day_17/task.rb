module Day17
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      input.execute.join(',')
    end

    def call2
      pr = input

      # pr.a = pr.instructions.size**8

      # (-100000).upto(10_0000) do |steps|
      #   pr.pointer = 0
      #   pr.output = []
      #   pr.a = (8**pr.instructions.size) + steps
      #   res = pr.execute

      #   p steps if res[0] == 2
      # end
      binding.pry

      0.upto(1000) do |steps|
        pr.pointer = 0
        pr.output = []
        pr.a = steps
        res = pr.execute

        p steps if res[0] == 2
      end
    end

    def input
      @input ||= Input.call(@sample)
    end
  end
end
