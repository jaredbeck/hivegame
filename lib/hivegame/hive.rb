module Hivegame
  class Hive
    include Enumerable

    attr_accessor :head

    def initialize
      @bugs = []
      @head = nil
    end

    def each
      @bugs.each {|b| yield b}
    end

    def empty?
      @bugs.empty?
    end

  end
end

