require 'nesta/app'

require_relative '../lib/nesta-plugin-related-by-category/init'
require_relative 'spec_helper'

require 'minitest/spec'
require 'minitest/autorun'
require 'mocha/setup'

describe "tests for finding related articles through an article's categories" do
  include Nesta::Plugin::RelatedByCategory::Helpers
  include ConfigSpecHelper

  before do
    stub_configuration
  end

  describe "setting up data from fixtures" do
    it "fetches the fixure content path" do
      Nesta::Config.content_path.must_equal 'fixtures/content'
    end

    it "instantiates articles correctly" do
      ledzep = Nesta::Page.find_by_path('ledzep')
      ledzep.heading.must_equal 'Led Zeppelin'
      ledzep.categories.count.must_equal 5
    end

    it "instantiates categories correctly" do
      rock = Nesta::Page.find_by_path('rock')
      rock.heading.must_equal 'Rock'
      rock.articles.count.must_equal 4
      headings = rock.articles.map { |a| a.heading }
      headings.must_equal ["Cream", "Jimi Hendrix", "Led Zeppelin", "Rare Earth"]
    end
  end

  describe "finding related articles" do
    before do
      @ledzep = Nesta::Page.find_by_path('ledzep')
      @bach = Nesta::Page.find_by_path('bach')
    end

    it "tests whether a page has related articles" do
      has_related_articles?(@ledzep).must_equal true
      has_related_articles?(@bach).must_equal false
    end

    it "finds related articles bound by a number (default parammeter)" do
      related_to_ledzep = related_by_category(@ledzep)
      related_to_ledzep.count.must_equal 3
      headings = related_to_ledzep.map { |article| article.heading }
      headings.must_equal ["Cream", "Jimi Hendrix", "Rare Earth"]
    end

    it "finds related articles bound by a number (specified parammeter)" do
      related_to_ledzep = related_by_category(@ledzep, 10)
      related_to_ledzep.count.must_equal 5
      headings = related_to_ledzep.map { |article| article.heading }
      headings.must_equal ["Cream", "Jimi Hendrix", "Rare Earth", "Pentangle", "The Meters"]
    end
  end
end
