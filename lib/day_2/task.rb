module Day2
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      input.count do |line|
        good_report?(line)
      end
    end

    def call2
      input.count do |line|
        good_report?(line) || report_with_one_error?(line)
      end
    end

    def input
      @input ||= Input.call(@sample)
    end

    private

    def good_report?(line)
      report = line.each_cons(2).map do |a, b|
        a - b
      end

      (report.all?(&:positive?) || report.all?(&:negative?)) && report.all? { |r| r.abs <= 3 }
    end

    def report_with_one_error?(line)
      0.upto(line.size - 1).any? do |i|
        good_report?(line[0...i] + line[i + 1..])
      end
    end
  end
end
