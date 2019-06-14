require 'nokogiri'

module FetchNews
  class FetchDynamicContent
    attr_reader :browser

    def initialize
      @browser = Watir::Browser.new FetchNews.configuration.browser.to_sym, headless: FetchNews.configuration.headless, options: { args: ["--no-sandbox"]}
    end

    def go url
      browser.goto url
    end

    def get_content target_html, &block
      result = []
      target_html.each do |link|
        result << block.call(link) if block_given?
      end

      result
    end

    def quit
      puts "browser exist with code 0"
      browser.close
    end
  end
end