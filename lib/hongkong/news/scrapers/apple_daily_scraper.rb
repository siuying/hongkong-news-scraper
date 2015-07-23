require_relative './phantom_scraper'

module Hongkong
  module News
    module Scrapers
      class AppleDailyScraper
        include PhantomScraper

        # Extract all news links from Apple Daily
        def news_links
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
          visit url

          document = Document.new
          document.source = 'appledaily'
          document.title = first("#articleContent h1").text.strip
          document.url = url
          document.html = html
          document.content = page.evaluate_script("HongKongNews.getInnerText('#masterContent')")
          document.screenshot_data = screenshot_data

          document
        end
      end
    end
  end
end
