require_relative './phantom_scraper'
require 'uri'

module Hongkong
  module News
    module Scrapers
      class OrientalDailyScraper
        include PhantomScraper

        LIST_URL = "http://orientaldaily.on.cc/"

        def name
          "orientaldaily"
        end

        # Extract all news links
        def news_links
          visit LIST_URL

          links = all("#articleListSELECT option").collect do |option|
            link = Link.new
            link.title = option.text
            link.url = URI::join(LIST_URL, option["value"]).to_s
            link
          end.reject { |l| l.url.to_s.end_with?("#") }
          links
        end

        # Extract article from page
        def news(url)
          visit url

          # wait for content to be loaded
          first("#contentCTN-right")
          
          document = Document.new
          document.source = name
          document.title = doc.search("h1").text
          document.url = url
          document.html = html
          document.content = page.evaluate_script("HongKongNews.getInnerText('#contentCTN-top')") + "\n" + page.evaluate_script("HongKongNews.getInnerText('#contentCTN-right')")
          document.screenshot_data = screenshot_data

          image = doc.search("#contentCTN .photo img").first
          document.image_url = URI::join(url, image["src"]).to_s if image
          document
        end
      end
    end
  end
end
