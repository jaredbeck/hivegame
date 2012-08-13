require "active_support/core_ext/module/delegation"
require "rgl/adjacency"
require "rgl/connected_components"

module Hivegame
  class Hive
    include Enumerable

    delegate :add_vertex, :to => :@bugs

    def initialize
      @bugs = RGL::AdjacencyGraph.new
    end

    def connected?
      connected_bugs = []
      @bugs.each_connected_component {|c| connected_bugs << c }
      connected_bugs == count
    end

    def each
      @bugs.each {|b| yield b}
    end

    def empty?
      @bugs.empty?
    end

  end
end

