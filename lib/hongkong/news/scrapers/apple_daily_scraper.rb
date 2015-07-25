require_relative './phantom_scraper'

module Hongkong
  module News
    module Scrapers
      class AppleDailyScraper
        include PhantomScraper
        
        def name
          "appledaily"
        end

        # Extract all news links from Apple Daily
        def news_links
          visit "http://hk.apple.nextmedia.com/"

          links = all("#article_ddl option").collect do |option|
            link = Link.new
            link.title = option.text
            link.url = option["value"]
            link
          end.reject { |l| l.url.nil? }
          links
        end

        # Extract article from page from Apple Daily
        def news(url)
          visit url

          document = Document.new
          document.source = name
          document.title = doc.search("#articleContent h1").text.strip
          document.url = url
          document.html = html
          document.content = page.evaluate_script("HongKongNews.getInnerText('#masterContent')")
          document.screenshot_data = screenshot_data
          document.image_url = doc.search("//meta[@property='og:image']/@content").first.text rescue nil
          document
        end
      end
    end
  end
end
