require 'hongkong/news/scrapers'
require 'pry'

RSpec.describe Hongkong::News::Scrapers::AppleDailyScraper do
  context "#news_links" do
    it "should return todays links" do
      scraper = Hongkong::News::Scrapers::AppleDailyScraper.new
      links = scraper.news_links
      expect(links).to_not be_empty

      urls = links.collect {|l| l.url}
      urls.each do |url|
        expect(url).to_not be_nil
      end
    end
  end

  context "#news" do
    it "should return news" do
      scraper = Hongkong::News::Scrapers::AppleDailyScraper.new
      document = scraper.news("http://hk.apple.nextmedia.com/news/art/20150720/19225923")
      expect(document).to_not be_nil
      expect(document.source).to eq("appledaily")
      expect(document.title).to eq("王宇子被禁問父母下落")
      expect(document.url).to eq("http://hk.apple.nextmedia.com/news/art/20150720/19225923")
      expect(document.content).to be_include("王宇北京的家已人去樓空")
      expect(document.html).to be_include("王宇北京的家已人去樓空")
      expect(document.screenshot_data).to_not be_nil
      expect(document.image_url).to eq("http://static.apple.nextmedia.com/images/apple-photos/video/20150720/392pix/1437338519_173b.jpg")
    end
  end
end
