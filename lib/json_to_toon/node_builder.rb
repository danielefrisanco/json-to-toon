# frozen_string_literal: true

require_relative 'object_node'
require_relative 'array_node'
require_relative 'value_node'

module JsonToToon
  class NodeBuilder
    def self.build(data, parent = nil)
      case data
      when Hash
        node = ObjectNode.new(parent)
        data.each do |key, value|
          child_node = self.build(value, node)

          node.add_key_value(key, child_node)
        end

        node

      when Array
        node = ArrayNode.new(parent)

        data.each do |item|
          child_node = self.build(item, node)

          node.add_child(child_node)
        end

        node

      when String, Numeric, TrueClass, FalseClass, NilClass
        ValueNode.new(data, parent)
      else
        ValueNode.new(data.to_s, parent)
      end
    end
  end
end
