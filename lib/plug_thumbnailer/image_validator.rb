# frozen_string_literal: true

require 'delegate'

module PlugThumbnailer
  class ImageValidator < ::SimpleDelegator

    attr_reader :config, :image

    def initialize(image)
      @config = ::PlugThumbnailer.page.config
      @image  = image

      super(config)
    end

    def call
      blacklist_urls.each do |url|
        return false if image.src && image.src.to_s[url]
      end

      true
    end

    private

    def blacklist_urls
      config.blacklist_urls
    end

  end
end
