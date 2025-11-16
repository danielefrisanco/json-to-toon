# frozen_string_literal: true

module JsonToToon
  class DataNode
    attr_accessor :parent

    attr_reader :indentation_level

    def initialize(parent = nil)
      @parent = parent
      @indentation_level = parent ? parent.indentation_level + 1 : 0
    end

    def to_s
      raise NotImplementedError, "#{self.class} must implement the 'to_s' method."
    end

    def add_child(child)
      raise NotImplementedError, "#{self.class} does not support adding children."
    end

    def indent(spaces = 2)
      ' ' * (@indentation_level * spaces)
    end

    def root
      current = self
      current = current.parent until current.parent.nil?
      current
    end
  end
end
