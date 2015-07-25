require_relative './phantom_scraper'
require 'uri'

module Hongkong
  module News
    module Scrapers
      class MingpaoScraper
        include PhantomScraper

        LIST_URL = "http://news.mingpao.com/pns/%E6%96%B0%E8%81%9E%E7%B8%BD%E8%A6%BD/web_tc/archive/latest"

        def name
          "mingpao"
        end

        # Extract all news links from Mingpao
        def news_links
          visit LIST_URL

          links = all(".listing ul li a").collect do |anchor|
            link = Link.new
            link.title = anchor.text
            link.url = URI::join(LIST_URL, anchor["href"]).to_s
            link
          end
          links
        end

        # Extract article from page from Mingpao
        def news(url)
          visit url

          # wait for content to be loaded
          first("article p")
          
          document = Document.new
          document.source = name
          document.title = doc.search("h1").text
          document.url = url
          document.html = html
          document.content = page.evaluate_script("HongKongNews.getInnerText('article')")
          document.image_url = doc.search("//meta[@property='og:image']/@content").first.text rescue nil
          document
        end
      end
    end
  end
end
