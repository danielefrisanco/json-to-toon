# frozen_string_literal: true

require_relative 'container_node'

module JsonToToon
  class ObjectNode < ContainerNode
    class KeyedValue
      attr_reader :key, :value_node

      def initialize(key, value_node)
        @key = key.to_s
        @value_node = value_node
      end

      def to_s
        @value_node.to_s
      end
    end

    def initialize(parent = nil)
      super
    end

    def keys
      @children.map(&:key)
    end

    def add_key_value(key, value_node)
      raise ArgumentError, 'Can only add DataNode objects as values.' unless value_node.is_a?(DataNode)

      @children << KeyedValue.new(key, value_node)
    end

    def to_s
      return indent.to_s if @children.empty?

      output = if parent
                 "#{indent}\n"
               else
                 String.new(encoding: Encoding::UTF_8)
               end

      child_strings = @children.map do |keyed_value|
        value_indent = '  ' * @indentation_level
        value_string = keyed_value.value_node.to_s.chomp
        if keyed_value.value_node.is_a?(ArrayNode)
          "#{value_indent}#{keyed_value.key}[#{keyed_value.value_node.children.size}]#{value_string.lstrip}"

        else

          newline = ''
          if keyed_value.value_node.is_a?(ObjectNode) && !keyed_value.value_node.children.empty?
            newline = "\n#{'  ' * keyed_value.value_node.indentation_level}"
          end

          "#{value_indent}#{keyed_value.key}: #{newline}#{value_string.lstrip}"
        end
      end

      output << child_strings.join("\n")

      output
    end
  end
end
