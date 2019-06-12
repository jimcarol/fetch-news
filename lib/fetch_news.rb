require 'mechanize'
require 'watir'
require_relative './fetch_news/static_page.rb'
require_relative './fetch_news/dynamic_page.rb'
require_relative './fetch_news/configuration.rb'

module FetchNews
  class << self
    attr_accessor :configuration

    def init(type)
      case type
        when "dynamic"
          FetchNews::FetchDynamicContent.new
        when "static"
          FetchNews::FetchStaticContent.new
        else
          raise "invalid type"
      end
    end

    def configure
      @configuration = FetchNews::Configuration.new

      yield configuration
    end
  end
end
