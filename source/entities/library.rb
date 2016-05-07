require 'set'
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
    hash = Hash.new 0

    @orders.each do |order|
      if order.book == book
        hash[order.reader] += 1
      end
    end

    hash = hash.sort_by { |_, value| value }.to_h
    hash.keys.last
  end

  def what_is_the_most_popular_book
    n_most_popular_book 1
  end

  def how_many_people_ordered_one_of_the_three_most_popular_books
    books = n_most_popular_book 3
    readers = Set.new

    @orders.each do |order|
      if books.include? order.book
        readers << order.reader
      end
    end

    readers
  end

  def n_most_popular_book(number)
    hash = Hash.new 0

    @orders.each { |order| hash[order.book] += 1 }
    hash = hash.sort_by { |_, value| value }.to_h

    if number == 1
      hash.keys.last
    elsif number > hash.length
      hash.keys
    else
      hash.keys[-number, number]
    end
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