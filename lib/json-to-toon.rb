# frozen_string_literal: true

require_relative 'json_to_toon/version'
require_relative 'json_to_toon/converter'

module JsonToToon
  def self.convert(json_string)
    Converter.convert(json_string)
  end
end
