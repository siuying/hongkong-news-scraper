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
              timeout: 180,
              logger: nil, 
              phantomjs_logger: StringIO.new,
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

        # call when shutdown phantomjs
        def cleanup
          wait_for_ajax
          page.driver.reset!
        end

        private

        # workaround for hang phantomjs
        def wait_for_ajax
          Timeout.timeout(Capybara.default_wait_time) do
            loop until finished_all_ajax_requests?
          end
        end

        def finished_all_ajax_requests?
          begin
            page.evaluate_script("(typeof jQuery !== \"undefined\") ? jQuery.active : 0").zero?
          rescue Exception => e
            puts "ignored excpetion wiating ajax: #{e}"
          end
        end

      end
    end
  end
end

