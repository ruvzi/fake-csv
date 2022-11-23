# frozen_string_literal: true

require_relative './csv_data'
require_relative './fake_data'

yaml_contents = File.read('template.yml')
template = YAML.safe_load(yaml_contents, symbolize_names: true)

rows = template[:rows]
data = template[:data]

fake_data = []

rows.times do |_i|
  fake = FakeData.new(data)
  fake_data << fake.fake_row
end

headers = data.each.with_object(:name).map(&:[])

fake_csv = CsvData.new(headers, fake_data)
fake_csv.write
