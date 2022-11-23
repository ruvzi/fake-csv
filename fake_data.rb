# frozen_string_literal: true

require 'faker'
require 'yaml'

class FakeData
  def initialize(data)
    @data = data
  end

  def fake_row
    row = []
    @data.each do |d|
      fake = d.key?(:options) ? send(d[:type].to_sym, d[:options]) : send(d[:type].to_sym)
      row << fake
    end
    row
  end

  def name
    Faker::Name.name
  end

  def age(options = {})
    args = {}
    args[:from] = options[:min] if options.key?(:min)
    args[:to] = options[:max] if options.key?(:max)
    Faker::Number.between(**args)
  end

  def postcode(options = {})
    locale = options[:local] || 'en-GB'
    Faker::Config.locale = locale
    Faker::Address.postcode
  end
end
