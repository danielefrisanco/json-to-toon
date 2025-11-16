# frozen_string_literal: true

require_relative 'container_node'

module JsonToToon
  class ArrayNode < ContainerNode
    def initialize(parent = nil)
      super
    end

    def standard_tabular_array?
      arr = @children

      return true if arr.empty?

      first_node = arr[0]
      return false unless first_node.is_a?(ObjectNode)

      first_hash_keys = first_node.keys.sort

      arr.all? do |item_node|
        next false unless item_node.is_a?(ObjectNode)
        next false unless item_node.keys.sort == first_hash_keys

        item_node.children.all? do |key_value_node|
          value_node = key_value_node.value_node
          value_node.is_a?(ValueNode)
        end
      end
    end

    def single_indent(spaces = 2)
      ' ' * (@indentation_level * spaces)
    end

    def to_s
      output = +''
      if standard_tabular_array?
        unless @children.empty?
          type = "{#{@children.first&.keys&.join(',')}}"
          output = type.to_s
        end
        output += ":\n"

        output += @children.map do |item|
          "#{indent}#{item.children.map { |c| c.to_s.chomp.lstrip }.join(',')}"
        end.join("\n")
        return output
      end

      output = +':'
      output_inline = true

      child_strings = @children.map do |child|
        output_inline = false if child.is_a?(ObjectNode) || child.is_a?(ArrayNode)
        child.to_s.chomp.lstrip
      end
      if output_inline
        output = +'' if parent.is_a?(ArrayNode)
        output << ' '
        output << child_strings.join(',')
      else
        output << "\n#{indent}- "
        output << child_strings.join("\n#{indent}- ")
      end

      output << "\n"

      output
    end
  end
end
