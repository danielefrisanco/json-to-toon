# frozen_string_literal: true

require 'json-to-toon' # Loads your main library file

RSpec.describe JsonToToon do
  # This block tests the version number is defined correctly
  it 'has a version number' do
    expect(JsonToToon::VERSION).not_to be nil
  end

  describe '.convert' do
    let(:json_input) do
      '{"user_data": {"first_name": "Daniele", "address_history": [{"city": "Rome"}]}}'
    end
    let(:expected_output_string) do
      <<~TOON_OUTPUT
        user_data:#{' '}
          first_name: Daniele
          address_history[1]{city}:
            Rome
      TOON_OUTPUT
        .chomp
    end

    it 'deeply converts json to toon' do
      result = JsonToToon.convert(json_input)

      expect(result).to eq(expected_output_string)
    end

    let(:complex_json_input) do
      File.read(File.expand_path('fixtures/complex_input.json', __dir__))
    end
    let(:expected_complex_output_string) do
      File.read(File.expand_path('fixtures/complex_output.toon', __dir__))
    end
    it 'converts complex json to toon' do
      result = JsonToToon.convert(complex_json_input)

      expect(result).to eq(expected_complex_output_string)
    end
    it 'raises an error for invalid JSON input' do
      invalid_json = '{"name": "Daniele"'
      expect { JsonToToon.convert(invalid_json) }.to raise_error(JsonToToon::ConversionError)
    end
    it 'raises a generic Error for unexpected internal failures' do
      allow(JsonToToon::NodeBuilder).to receive(:build).and_raise(StandardError, 'Internal node failure')

      expect { JsonToToon.convert(json_input) }.to raise_error(JsonToToon::Error, /Internal node failure/)
    end
  end
end
