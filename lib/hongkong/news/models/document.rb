module Hongkong
  module News
    class Document < Struct.new(:id, :source, :title, :url, :html, :content, :screenshot_data)
    end
  end
end
