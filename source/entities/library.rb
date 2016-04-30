require 'singleton'
require 'set'

require 'entities/book'
require 'entities/order'
require 'entities/reader'
require 'entities/author'

require 'parsers/parser'

class Library
  include Parser
  include Singleton

  attr_reader :books
  attr_reader :orders
  attr_reader :readers
  attr_reader :authors

  def initialize
    # data = Hash.new { |hash, key| hash[key] = Array.new }
    data = read
    @books = data[:books]
    @orders = data[:orders]
    @readers = data[:readers]
    @authors = data[:authors]
  end

  def add_book(*books)
    @books += books
  end

  def add_order(*orders)
    @orders += orders
  end

  def add_reader(*readers)
    @readers += readers
  end

  def add_author(*authors)
    @authors += authors
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

  def save
    data = Hash.new
    data[:books] = @books
    data[:orders] = @orders
    data[:readers] = @readers
    data[:authors] = @authors
    write(data)
  end
end