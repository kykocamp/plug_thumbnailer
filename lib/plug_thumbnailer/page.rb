# frozen_string_literal: true

require 'plug_thumbnailer/response'
require 'plug_thumbnailer/processor'
require 'plug_thumbnailer/scraper'

module PlugThumbnailer
  class Page

    attr_reader :url, :options, :source

    def initialize(url, options = {})
      @url     = url
      @options = options

      set_options
    end

    def generate
      @source = processor.call(url)
      scraper.call
    end

    def config
      @config ||= ::PlugThumbnailer.config.dup
    end

    private

    def set_options
      options.each { |k, v| config.send("#{k}=", v) }
    end

    def processor
      @processor ||= ::PlugThumbnailer::Processor.new
    end

    def scraper
      @scraper ||= ::PlugThumbnailer::Scraper.new(source, processor.url)
    end

  end
end
