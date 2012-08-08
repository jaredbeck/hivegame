module Hivegame
  class Hive
    include Enumerable

    def initialize
      @bugs = []
    end

    def each
      @bugs.each {|b| yield b}
    end

    def empty?
      @bugs.empty?
    end

  end
end

