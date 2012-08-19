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

    # A board can enumerate *occupied* hexes
    include Enumerable

    # To conserve memory, the internal representation of a board
    # is a hash mapping coordinates to hexes.  A three-dimensional
    # array would be mostly empty, thus wasting memory.
    def initialize
      @board = {[0,0,0] => Hex.new}
    end

    def add(point, bug)
      return ArgumentError unless point.is_a? Array
      r,c,h = point[0], point[1], point[2]
      if h > 1
        hex_below = hex([r,c,h-1])
        return false unless hex_below.occupied?
      end
      hex = hex([r,c,h])
      return false if hex.occupied?

      @board[[r,c,h]].bug = bug
      return true
    end

   # `draw` writes the board to stdout
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

    # `each` enumerates occupied hexes
    def each
      occupied_hexes.each { |hex| yield hex }
    end

    def empty?
      count == 0
    end

    # `hex` returns the hex at the specified `point`,
    # creating a hex if none exists.
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

    def occupied_hexes
      return @board.select { |point, hex| hex.occupied? }
    end
  end
end
