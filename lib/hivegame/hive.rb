require "active_support/core_ext/module/delegation"
require "rgl/adjacency"
require "rgl/connected_components"

module Hivegame
  class Hive
    include Enumerable

    delegate :add_edge, :add_vertex, :remove_vertex, :to => :@bugs

    def initialize
      @bugs = RGL::AdjacencyGraph.new
    end

    def connected?
      subgraphs = []
      @bugs.each_connected_component {|c| subgraphs << c }
      subgraphs.length == 1
    end

    def each
      @bugs.each {|b| yield b}
    end

    def empty?
      @bugs.empty?
    end

  end
end

