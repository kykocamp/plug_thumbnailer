# frozen_string_literal: true

require 'image_info'

module PlugThumbnailer
  class ImageParser

    attr_reader :images

    def initialize(urls)
      @images = perform? ? image_info(urls) : default_images(urls)
    end

    def size
      images.first.size
    rescue
      nil
    end

    def type
      images.first.type
    rescue
      nil
    end

    private

    def default_images(urls)
      Array(urls).compact.map(&method(:build_default_image))
    end

    def build_default_image(uri)
      NullImage.new(uri)
    end

    def perform?
      ::PlugThumbnailer.page.config.image_stats
    end

    def max_concurrency
      ::PlugThumbnailer.page.config.max_concurrency
    end

    def image_info(urls)
      ::ImageInfo.from(urls, max_concurrency: max_concurrency)
    rescue
      default_images(urls)
    end

    class NullImage
      attr_reader :uri

      def initialize(uri)
        @uri = uri
      end

      def size
        [0, 0]
      end

      def type
      end
    end

  end
end
