# frozen_string_literal: true

require 'csv'
class CsvData
  def initialize(headers, rows, output_file)
    @headers = headers
    @rows = rows
    @output_file = output_file
  end

  def write
    CSV.open(@output_file, 'w') do |csv|
      csv << @headers
      @rows.each do |row|
        csv << row
      end
    end
  end
end
