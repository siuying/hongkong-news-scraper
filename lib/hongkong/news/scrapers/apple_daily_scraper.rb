require_relative './phantom_scraper'
require 'tempfile'

module Hongkong
  module News
    module Scrapers
      class AppleDailyScraper
        include PhantomScraper

        # Extract all news links from Apple Daily
        def news_urls
          new_session
          visit "http://hk.apple.nextmedia.com/"

          all("#article_ddl option").collect do |option|
            link = Link.new
            link.title = option.text
            link.url = option["value"]
            link
          end
        end

        # Extract article from page from Apple Daily
        def news(url)
          new_session
          visit url

          document = Document.new
          document.source = 'appledaily'
          document.title = page.evaluate_script("document.querySelector('#articleContent h1').innerText").strip
          document.url = url
          document.html = page.body
          document.content = page.evaluate_script("HongKongNews.getInnerText('#masterContent')")
          document.screenshot_data = screenshot_data

          page.reset!
          document
        end
      end
    end
  end
end
