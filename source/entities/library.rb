require 'singleton'

require 'entities/book'
require 'entities/order'
require 'entities/reader'
require 'entities/author'

require 'parsers/parser'

class Library
  include Parser
  include Singleton

  @@entities = [
      :books,
      :orders,
      :readers,
      :authors
  ]

  attr_reader *@@entities

  def initialize
    load
  end

  def add(*entities)
    entities.each do |entity|
      destination = "#{entity.class.to_s.downcase}s".to_sym

      if @@entities.include? destination
        instance_eval "@#{destination} << entity"
      end
    end
  end

  def who_often_takes_the_book(book)
    @orders.select { |order| order.book == book }.group_by(&:reader)
        .sort_by { |_, orders| orders.size }.to_h.keys.last
  end

  def what_is_the_most_popular_book
    n_most_popular_book(1)&.first
  end

  def how_many_people_ordered_one_of_the_three_most_popular_books
    books = n_most_popular_book 3
    @orders.collect { |order| order.reader if books.include? order.book }.compact.uniq
  end

  def n_most_popular_book(number)
    @orders.group_by(&:book).max_by(number) { |_, orders| orders.size }.to_h.keys
  end

  def load
    disassemble read
  end

  def save
    write assemble Hash.new
  end

  def assemble(hash)
    @@entities.each do |entity|
      hash[entity] = instance_variable_get "@#{entity}"
    end

    hash
  end

  def disassemble(data)
    @@entities.each do |entity|
      instance_variable_set "@#{entity}", data[entity]
    end
  end
end