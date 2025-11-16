# frozen_string_literal: true

require 'json'
require_relative 'node_builder'
require_relative 'errors'

module JsonToToon
  class Converter
    def self.convert(json_string)
      raise ArgumentError, 'Input must be a String.' unless json_string.is_a?(String)

      data_hash = JSON.parse(json_string, symbolize_names: true)

      root_node = NodeBuilder.build(data_hash)
      root_node.to_s
    rescue JSON::ParserError => e
      raise ConversionError, "Invalid JSON structure provided: #{e.message}"
    rescue StandardError => e
      raise Error, "An unexpected error occurred during conversion: #{e.message}"
    end
  end
end
