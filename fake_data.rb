# frozen_string_literal: true

require 'faker'
require 'yaml'

class FakeData
  def initialize(data, index)
    @data = data
    @index = index
  end

  def fake_row
    row = []
    @data.each do |d|
      fake = d.key?(:options) ? send(d[:type].to_sym, d[:options]) : send(d[:type].to_sym)
      row << fake
    end
    row
  end

  attr_reader :index

  def app_name
    Faker::App.name
  end

  def name
    Faker::Name.name
  end

  def email
    Faker::Internet.email
  end

  def phone
    Faker::PhoneNumber.cell_phone_with_country_code
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
    from_date = options[:min]
    to_date = options[:max]
    args[:from] = from_date == 'today' ? Date.today : from_date if from_date
    args[:to] = to_date == 'today' ? Date.today : to_date if to_date
    Faker::Date.between(**args)
  end

  def company_name
    Faker::Company.name
  end

  def company_business_id
    Faker::Company.spanish_organisation_number
  end

  def word
    Faker::Lorem.word
  end

  def boolean
    [true, false].sample
  end

  def postcode(options = {})
    locale = options[:local] || 'en-GB'
    Faker::Config.locale = locale
    Faker::Address.postcode
  end

  def enum(options)
    list = options[:list]
    return list.sample unless list.first.is_a?(Hash)

    list_options = {}
    list.each { |l| list_options[l[:value]] = l[:weight] }
    weighted_option(list_options)
  end

  def cycle(options)
    list = options[:list]
    list ||= (options[:min]..options[:max]).to_a
    idx = (@index - 1) % list.count
    list[idx]
  end

  def any_of_list(options)
    options = options.dup
    min = options.delete(:min) if options.key?(:min)
    max = options.delete(:max) if options.key?(:max)
    list = generated_array(options)
    value = list[@index - 1]
    value ||= ((min || 1)..max).to_a.sample if max
    value
  end

  def uuid
    Faker::Internet.uuid
  end

  private

  def generated_array(options)
    list = []
    options.each do |item, count|
      list += Array.new(count, item)
    end
    list
  end

  def weighted_option(options)
    current = 0
    max = options.values.inject(:+)
    random_value = rand(max) + 1
    options.each do |key, val|
      current += val
      return key if random_value <= current
    end
  end
end
