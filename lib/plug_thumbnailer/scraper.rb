# frozen_string_literal: true

require 'delegate'
require 'active_support/core_ext/object/blank'
require 'active_support/inflector'

require 'plug_thumbnailer/parser'
require 'plug_thumbnailer/models/website'
require 'plug_thumbnailer/scrapers/default/title'
require 'plug_thumbnailer/scrapers/opengraph/title'
require 'plug_thumbnailer/scrapers/default/description'
require 'plug_thumbnailer/scrapers/opengraph/description'
require 'plug_thumbnailer/scrapers/default/images'
require 'plug_thumbnailer/scrapers/opengraph/images'
require 'plug_thumbnailer/scrapers/default/videos'
require 'plug_thumbnailer/scrapers/opengraph/videos'
require 'plug_thumbnailer/scrapers/default/favicon'
require 'plug_thumbnailer/scrapers/opengraph/favicon'

module PlugThumbnailer
  class Scraper < ::SimpleDelegator

    attr_reader :document, :source, :url, :config, :website

    def initialize(source, url)
      @source       = source
      @url          = url
      @config       = ::PlugThumbnailer.page.config
      @document     = parser.call(source)
      @website      = ::PlugThumbnailer::Models::Website.new
      @website.url  = url

      super(config)
    end

    def call
      config.attributes.each do |name|
        config.scrapers.each do |scraper_prefix|
          scraper_class(scraper_prefix, name).new(document, website).call(name.to_s)
          break unless website.send(name).blank?
        end
      end

      website
    end

    private

    def scraper_class(prefix, name)
      prefix = "::PlugThumbnailer::Scrapers::#{prefix.to_s.camelize}"
      name = name.to_s.camelize
      "#{prefix}::#{name}".constantize
    rescue NameError
      raise ::PlugThumbnailer::ScraperInvalid, "scraper named '#{prefix}::#{name}' does not exists."
    end

    def parser
      ::PlugThumbnailer::Parser.new
    end

  end
end
