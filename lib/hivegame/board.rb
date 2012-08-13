module Hivegame

  class Hex
    attr_accessor :bug
    def initialize()
      @bug = nil
    end

    def occupied?
      return !@bug.nil?
    end
  end

  # A Hive board is a three-dimensional matrix of hexagonal cells,
  # which are identified by a 3-tuple of coordinates.
  class Board
    def initialize
      @board = {[0,0,0] => Hex.new}
    end

    def add(r,c,h, bug)
      if h > 1
        hex_below = hex([r,c,h-1])
        return false unless hex_below.occupied?
      end
      hex = hex([r,c,h])
      return false if hex.occupied?

      @board[[r,c,h]].bug = bug
      return true
    end

   # This will print the board out to the console
   def draw
     @rows.times do |row|
       line = "%03d:" % row
       (@cols - row).times {line << ' '}

       @cols.times do |col|
         line << (@board[row][col].bug || '.').to_s
         line << ' '
       end

       puts line
     end
   end

   def empty?
     true
   end

    def hex point
      return ArgumentError unless point.is_a? Array
      @board[point] = Hex.new if @board[point].nil?
      @board[point]
    end

    def neighbors point
      return ArgumentError unless point.is_a? Array
      row, col, height = point[0], point[1], point[2]
      offsets = [[-1,-1,0], [-1,0,0], [0,-1,0], [0,1,0], [1,0,0], \
        [1,1,0], [0,0,1], [0,0,-1]]
      offsets.map do |r,c,h|
        [row+r, col+c, height+h]
      end
    end
  end
end
