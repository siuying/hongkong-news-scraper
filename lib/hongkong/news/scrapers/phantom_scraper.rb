require 'capybara/poltergeist'

module Hongkong
  module News
    module Scrapers
      module PhantomScraper
        include Capybara::DSL

        def new_session
          Capybara.register_driver :poltergeist do |app|
            extensions = [
              File.expand_path("../phantom_scraper_extension.js", __FILE__)
            ]
            Capybara::Poltergeist::Driver.new(app,
              extensions: extensions,
              js_errors: false,
              phantomjs: ENV['PHANTOMJS_PATH'])
          end

          Capybara.configure do |config|
            config.default_driver = :poltergeist
            config.javascript_driver = :poltergeist
            config.run_server = false
          end

          @session = Capybara::Session.new(:poltergeist)
          @session.driver.headers = {'User-Agent' => 'Mozilla/5.0 (Macintosh; Intel Mac OS X)'}
          @session
        end

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
          @session.html
        end
      end
    end
  end
end
