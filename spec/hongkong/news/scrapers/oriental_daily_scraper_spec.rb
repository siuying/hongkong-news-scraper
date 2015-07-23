require 'hongkong/news/scrapers'
require 'pry'

RSpec.describe Hongkong::News::Scrapers::OrientalDailyScraper do
  context "#news_links" do
    it "should return todays links" do
      scraper = Hongkong::News::Scrapers::OrientalDailyScraper.new
      links = scraper.news_links
      expect(links).to_not be_empty

      urls = links.collect {|l| l.url}
      urls.each do |url|
        expect(url).to_not be_nil
        expect(url).to_not eq("http://orientaldaily.on.cc/#")
      end
    end
  end

  context "#news" do
    it "should return news" do
      scraper = Hongkong::News::Scrapers::OrientalDailyScraper.new
      document = scraper.news("http://orientaldaily.on.cc/cnt/news/20150723/00174_001.html")
      expect(document).to_not be_nil
      expect(document.source).to eq("orientaldaily")
      expect(document.title).to eq("錯算肝酵素 屯院恐禍萬人")
      expect(document.url).to eq("http://orientaldaily.on.cc/cnt/news/20150723/00174_001.html")
      expect(document.content).to be_include("郭昨解釋，肝酵素分析儀於一三年八月安裝")
      expect(document.html).to be_include("郭昨解釋，肝酵素分析儀於一三年八月安裝")
      expect(document.screenshot_data).to_not be_nil
      expect(document.image_url).to eq("http://orientaldaily.on.cc/cnt/news/20150723/photo/0723-00174-001h1.jpg")
    end
  end
end
