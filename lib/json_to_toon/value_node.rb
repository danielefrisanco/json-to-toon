# frozen_string_literal: true

require_relative 'data_node'

module JsonToToon
  class ValueNode < DataNode
    attr_reader :value

    def initialize(value, parent = nil)
      super(parent)
      @value = value
    end

    def escape(value)
      return 'null' if value.nil?
      return value unless value.is_a?(String)
      return "\"#{value.gsub('"', '\"')}\"" if value.match(/"/)
      return "\"#{value}\"" if value.match(/,/)
      return "\"#{value}\"" if value.match(/^(-\s)/)
      return "\"#{value.gsub("\n", '\n')}\"" if value.match(/\n/)

      value
    end

    def to_s
      formatted_value = case @value
                        when String
                          escape(@value)
                        when Numeric, TrueClass, FalseClass
                          @value.to_s
                        when NilClass
                          'null'
                        else
                          @value.to_s
                        end

      "#{indent}#{formatted_value}"
    end

    def add_child(_child)
      raise NoMethodError, "A #{self.class} cannot have children."
    end
  end
end
