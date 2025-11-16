JsonToToon

JsonToToon is a unique Ruby gem designed to convert standard JSON strings into a custom, highly structured text format (dubbed the "Toon Format") optimized for human readability and specific parsing needs.

Unlike standard JSON or YAML, the Toon Format includes structural metadata like array counts and keys for tabular data, making it useful for configuration systems or structured data display.

✨ Features

- **Deep Symbolization**: All JSON keys are deeply symbolized internally for easy processing.
- **Tree Structure Conversion**: JSON is converted into a hierarchical `DataNode` tree (`ObjectNode`, `ArrayNode`, `ValueNode`).
- **Custom Toon Format Output**: Converts the structure into a custom, indented string output.
- **Tabular Array Detection**: Automatically detects arrays containing homogenous records (hash keys are all the same, values are primitive) and outputs them using a concise tabular syntax: `array_key[count]{key1,key2}:`.
- **Clean Error Handling**: Uses custom `JsonToToon::ConversionError` for invalid input.
- **Deeply Nested JSONs Handling**: The gem is specifically designed to handle and accurately represent highly complex and **deeply nested** JSON structures in the Toon Format.

⚙️ Installation

Add this line to your application's `Gemfile`:
```ruby
gem 'json-to-toon'
```

And then execute:
```bash
bundle install
```

Or install it yourself as:
```bash
gem install json-to-toon
```

🚀 Usage

The primary function of the gem is the `JsonToToon.convert` class method, which takes a JSON string and returns the formatted Toon string.

Simple Example

```ruby
require 'json-to-toon'

json_string = '{"title": "The Report", "version": 1.0}'
toon_output = JsonToToon.convert(json_string)

puts toon_output

# Output:
# title: The Report
# version: 1.0
```

📝 What is the Toon Format?

This gem converts JSON into the Toon Format, a custom, structured data serialization format designed for specialized hierarchical data display.

The format is characterized by:

- Two-space indentation.

- The use of special notation for arrays, particularly when detecting tabular data (arrays of uniform hashes).

- Keys containing structural metadata (like the count and keys in `team_members[2]{id,role}:`).

- You can find the full specification and details on this format here: [Toon Format Specification](https://toonformat.dev/).

Complex Example (Demonstrating Tabular Arrays and Nesting)

Given this input JSON:
```json
{
  "project_details": {
    "name": "Project Alpha",
    "status": "In Progress"
  },
  "team_members": [
    { "id": 1, "role": "Engineer" },
    { "id": 2, "role": "Designer" }
  ],
  "tasks": [
    "documentation",
    "refactoring"
  ]
}
```

The output "Toon Format" string will be:
```ruby
require 'json-to-toon'

complex_json = File.read('input.json') # Assume file reading here

toon_output = JsonToToon.convert(complex_json)

puts toon_output

# Output:
# project_details:
# name: Project Alpha
# status: In Progress
# team_members[2]{id,role}:
# 1,Engineer
# 2,Designer
# tasks:
# - documentation
# - refactoring
```
Notice the key differences:

1. `project_details` is indented normally.

2. `team_members` is detected as a tabular array (`[2]{id,role}:`) and its items are output as comma-separated values (CSV style).

3. `tasks` (an array of simple values) is output as a standard dashed list.

🛑 Error Handling

The gem uses custom exceptions for easy handling within your application:

 | Exception | Base Class | Triggered When
|-|-|-|
`ArgumentError` | `StandardError` | Input is not a String.
`JsonToToon::ConversionError` | `JsonToToon::Error` | The input string is syntactically invalid JSON (wraps `JSON::ParserError`).

Example of catching a conversion failure:
```ruby
require 'json-to-toon'

begin
  JsonToToon.convert('{broken:')
rescue JsonToToon::ConversionError => e
  puts "Conversion failed: #{e.message}"
end

# Output: Conversion failed: Invalid JSON input: expected ',' or '}' after object key and value
```

🧑‍💻 Development

After checking out the repository, run `bundle install` to install dependencies.

To run the tests and linting:

```bash
bundle exec rspec # Runs the test suite

bundle exec rubocop -a # Runs the linter and auto-corrects offenses
```