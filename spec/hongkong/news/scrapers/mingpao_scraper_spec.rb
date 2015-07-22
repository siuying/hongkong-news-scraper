require 'hongkong/news/scrapers'
require 'pry'

RSpec.describe Hongkong::News::Scrapers::MingpaoScraper do
  let(:scraper) { return Hongkong::News::Scrapers::MingpaoScraper.new }

  context "#news_links" do
    it "should return todays links" do
      links = scraper.news_links
      expect(links).to_not be_empty
      links.each do |link|
        expect(link).to_not be_nil
        expect(link.url.match(/^http/)).to be_truthy
      end
    end
  end

  context "#news" do
    it "should return news" do
      document = scraper.news("http://news.mingpao.com/pns/%E6%A2%81%E5%A4%A7%E6%8F%9B%E7%8F%AD%20%E6%9B%BE%E5%BE%B7%E6%88%90%E9%84%A7%E5%9C%8B%E5%A8%81%E9%81%AD%E6%92%A4%20%20%E6%B6%88%E6%81%AF%EF%BC%9A%E5%9B%A0%E4%B8%8D%E9%85%8D%E5%90%88%E7%89%B9%E9%A6%96%E5%B7%A5%E4%BD%9C/web_tc/article/20150722/s00001/1437501797507")
      expect(document).to_not be_nil
      expect(document.title).to eq("梁大換班 曾德成鄧國威遭撤 消息：因不配合特首工作")
      expect(document.url).to eq("http://news.mingpao.com/pns/%E6%A2%81%E5%A4%A7%E6%8F%9B%E7%8F%AD%20%E6%9B%BE%E5%BE%B7%E6%88%90%E9%84%A7%E5%9C%8B%E5%A8%81%E9%81%AD%E6%92%A4%20%20%E6%B6%88%E6%81%AF%EF%BC%9A%E5%9B%A0%E4%B8%8D%E9%85%8D%E5%90%88%E7%89%B9%E9%A6%96%E5%B7%A5%E4%BD%9C/web_tc/article/20150722/s00001/1437501797507")
      expect(document.content).to be_include("梁振英未有回應")
      expect(document.html).to be_include("梁振英未有回應")
      expect(document.screenshot_data).to_not be_nil
    end
  end
end
