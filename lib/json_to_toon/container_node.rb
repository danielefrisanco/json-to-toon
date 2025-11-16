# frozen_string_literal: true

require_relative 'data_node'

module JsonToToon
  class ContainerNode < DataNode
    attr_reader :children

    def initialize(parent = nil)
      super
      @children = []
    end

    def add_child(child)
      raise ArgumentError, 'Can only add objects of type DataNode as children.' unless child.is_a?(DataNode)

      @children << child
    end

    def to_s
      raise NotImplementedError, "#{self.class} must implement the 'to_s' method for specific formatting."
    end
  end
end
