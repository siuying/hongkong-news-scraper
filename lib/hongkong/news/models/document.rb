module Hongkong
  module News
    class Document < Struct.new(:id, :source, :title, :url, :html, :content, :screenshot_data, :image_url)
    end
  end
end
