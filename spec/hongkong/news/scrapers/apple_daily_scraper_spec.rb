require 'hongkong/news/scrapers'
require 'pry'

RSpec.describe Hongkong::News::Scrapers::AppleDailyScraper do
  context "#news_links" do
    it "should return todays links" do
      scraper = Hongkong::News::Scrapers::AppleDailyScraper.new
      urls = scraper.news_links
      expect(urls).to_not be_empty
    end
  end

  context "#news" do
    it "should return news" do
      scraper = Hongkong::News::Scrapers::AppleDailyScraper.new
      document = scraper.news("http://hk.apple.nextmedia.com/news/art/20150720/19225923")
      expect(document).to_not be_nil
      expect(document.title).to eq("王宇子被禁問父母下落")
      expect(document.url).to eq("http://hk.apple.nextmedia.com/news/art/20150720/19225923")
      expect(document.content).to be_include("王宇北京的家已人去樓空")
      expect(document.html).to be_include("王宇北京的家已人去樓空")
      expect(document.screenshot_data).to_not be_nil
    end
  end
end
