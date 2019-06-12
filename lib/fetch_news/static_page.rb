module FetchNews
  class FetchStaticContent
    attr_reader :agent
    attr_accessor :page

    def initialize
      @agent = Mechanize.new
    end

    def go url
      @page = @agent.get(url)
    end

    def get_content target_html, &block
      target_html.map do |link|
        block.call(link) if block_given?
      end
    end
  end
end