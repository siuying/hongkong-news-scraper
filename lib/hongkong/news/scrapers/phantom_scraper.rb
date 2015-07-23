require 'capybara/poltergeist'
require 'nokogiri'
require 'tempfile'

module Hongkong
  module News
    module Scrapers
      module Initializer
        def self.configure
          Capybara.register_driver :poltergeist do |app|
            extensions = [
              File.expand_path("../phantom_scraper_extension.js", __FILE__)
            ]
            Capybara::Poltergeist::Driver.new(app,
              extensions: extensions,
              js_errors: false,
              phantomjs: ENV['PHANTOMJS_PATH'])
          end

          Capybara.default_wait_time = 5
          Capybara.configure do |config|
            config.default_driver = :poltergeist
            config.javascript_driver = :poltergeist
            config.run_server = false
          end
        end
          self.configure
      end

      module PhantomScraper
        include Capybara::DSL

        def screenshot_data(filename='screenshot.gif')
          data = nil
          file = Tempfile.new(filename)
          begin
            page.save_screenshot(file.path, full: true)
            data = file.read
          ensure
            file.close
            file.unlink
          end
          data
        end

        def html
          page.html
        end

        # Get a Nokogiri Document for current page
        def doc
          unless @doc
            @doc = Nokogiri::HTML(html)
          end
          @doc
        end
      end
    end
  end
end

