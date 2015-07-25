module Hongkong
  module News
    class Document < Struct.new(:id, :source, :title, :url, :html, :content, :image_url)
    end
  end
end
