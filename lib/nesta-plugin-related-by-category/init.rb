module Nesta
  module Plugin
    module RelatedByCategory

      module Helpers
        def has_related_articles?(page)
          !(Nesta::Plugin::RelatedByCategory.articles_through_categories(page).empty?)
        end

        def related_by_category(page, number=3)
         Nesta::Plugin::RelatedByCategory.for_page(page, number)
        end
      end

      def self.ranked_by_relevance(page)
        results = {}
        articles_through_categories(page).each do |article|
          rank = relevance(page, article)
          if results.has_key? rank
            results[rank] << article
          else
            results.store(rank, [article])
          end
        end
        results.sort.reverse.flatten.reject {|el| !el.class.eql? Page}
      end

      def self.articles_through_categories(page)
        related = page.categories.map {|c| c.articles}.flatten
        set = Set.new(related).to_a
        set.delete page
        set
      end

      def self.relevance(page, other)
        (tags(page) & tags(other)).count
      end

      def self.tags(page)
        page.categories.map {|c| c.heading}
      end

      def self.display(results, number)
        results.take(number)
      end

      def self.for_page(page, number)
        display(ranked_by_relevance(page), number)
      end
    end
  end

  class App
    helpers Nesta::Plugin::RelatedByCategory::Helpers
  end
end

