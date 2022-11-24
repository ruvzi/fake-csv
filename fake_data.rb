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
    "#{Faker::Name.first_name} #{Faker::Name.last_name}"
  end

  def id
    Faker::IDNumber.valid
  end

  def integer(options = {})
    args = {}
    args[:from] = options[:min] if options.key?(:min)
    args[:to] = options[:max] if options.key?(:max)
    Faker::Number.between(**args)
  end

  def date(options = {})
  args = {}
  args[:from] = options[:min] if options.key?(:min)
  args[:to] = options[:max] if options.key?(:max)
  Faker::Date.between(**args)
end

  def postcode(options = {})
    locale = options[:local] || 'en-GB'
    Faker::Config.locale = locale
    Faker::Address.postcode
  end

  def enum(options)
    list = options[:list]
    return list.shuffle.first unless list.first.kind_of?(Hash)

    list_options = {}
    list.each { |l| list_options[l[:value]] = l[:weight] }
    weighted_option(list_options)
  end

  private

  def weighted_option(options)
    current, max = 0, options.values.inject(:+)
    random_value = rand(max) + 1
    options.each do |key,val|
       current += val
       return key if random_value <= current
    end
  end
end
