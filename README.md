# Nesta::Plugin::RelatedByCategory

A plugin for finding related articles to a Nesta article, based on a dead-simple idea:

*Given pages A and B, the more categories A and B have in common, the higher B's relevance to A.

## Installation

Add this line to your application's Gemfile:

    gem 'nesta-plugin-related-by-category'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nesta-plugin-related-by-category

## Usage

In your Nesta `/views` folder, declare a `related_articles.haml` with something like the following:

    - if has_related_articles?(@page)
      %section.related-articles
        %h2 Related articles
        %ul
          - related_by_category(@page).each do |article|
            %li
              %a(href="#{article.abspath}")= article.heading

Then, at the bottom of your template file (`page.haml is default), reference it:

    = haml :related_articles, :layout => false

By default, the plugin will display 3 articles; this can be overridden by a number of your choice:

    related_by_category(@page, 5) # 2nd argument is the number of articles to display.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
