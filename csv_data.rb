# frozen_string_literal: true

require 'csv'

class CsvData
  OUTPUT = 'fake.csv'

  def initialize(headers, rows)
    @headers = headers
    @rows = rows
  end

  def write
    CSV.open(OUTPUT, 'w') do |csv|
      csv << @headers
      @rows.each do |row|
        csv << row
      end
    end
  end
end
