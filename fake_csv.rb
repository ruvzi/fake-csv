# frozen_string_literal: true

require_relative './csv_data'
require_relative './fake_data'

Psych::ClassLoader::ALLOWED_PSYCH_CLASSES = [Date].freeze

module Psych
  class ClassLoader
    ALLOWED_PSYCH_CLASSES = [].freeze unless defined? ALLOWED_PSYCH_CLASSES
    class Restricted < ClassLoader
      def initialize(classes, symbols)
        @classes = classes + Psych::ClassLoader::ALLOWED_PSYCH_CLASSES.map(&:to_s)
        @symbols = symbols
        super()
      end
    end
  end
end

name = ARGV[0] || 'demo'

yaml_contents = File.read("templates/#{name}.yml")
template = YAML.safe_load(yaml_contents, symbolize_names: true)

rows = template[:rows]
data = template[:data]

fake_data = []

rows.times do |i|
  fake = FakeData.new(data, i + 1)
  fake_data << fake.fake_row
end

headers = data.each.with_object(:name).map(&:[])

fake_csv = CsvData.new(headers, fake_data, "csv/#{name}.csv")
fake_csv.write
