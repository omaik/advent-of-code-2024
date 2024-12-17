module Day15
  class Task
    def initialize(sample)
      @sample = sample
    end

    def call1
      @map, @moves = input

      @robot_position = get_robot_position

      @moves.each do |move|
        perform_move(move)
      end

      print_map

      grep_os.sum do |os|
        os[0] * 100 + os[1]
      end
    end

    def call2
      @map, @moves = input
      # enlarge_map

      print_map
    end

    def input
      @input ||= Input.call(@sample)
    end

    def get_robot_position
      @map.each_with_index do |row, y|
        row.each_with_index do |cell, x|
          return [y, x] if cell == '@'
        end
      end
    end

    def grep_os
      os = []
      @map.each.with_index do |row, y|
        row.each.with_index do |cell, x|
          os << [y, x] if cell == 'O'
        end
      end

      os
    end

    def print_map
      puts '---------'
      @map.each do |row|
        puts row.join('')
      end
      puts '---------'
    end

    def value(position)
      @map.dig(*position)
    end

    def perform_move(move)
      sequence = generate_sequence(move)
      binding.pry if sequence.nil?

      sequence.each do |position|
        value = value(position)

        case value
        when '.'
          diff = sequence.index(position)

          # binding.pry
          diff.downto(1) do |i|
            position_a = sequence[i]
            position_b = sequence[i - 1]

            value_a = value(position_a)
            value_b = value(position_b)

            @map[position_a[0]][position_a[1]] = value_b
            @map[position_b[0]][position_b[1]] = value_a
          end

          @map[@robot_position[0]][@robot_position[1]] = '.'
          @robot_position = sequence.first
          @map[@robot_position[0]][@robot_position[1]] = '@'

          break
        when '#'
          break
        else
          next
        end
      end
    end

    def generate_sequence(move)
      case move
      when '^'
        (@robot_position[0] - 1).downto(0).map do |y|
          [y, @robot_position[1]]
        end
      when 'v'
        (@robot_position[0] + 1).upto(@map.size - 1).map do |y|
          [y, @robot_position[1]]
        end
      when '<'
        (@robot_position[1] - 1).downto(0).map do |x|
          [@robot_position[0], x]
        end
      when '>'
        (@robot_position[1] + 1).upto(@map[0].size - 1).map do |x|
          [@robot_position[0], x]
        end
      end
    end
  end
end
