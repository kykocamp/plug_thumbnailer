# frozen_string_literal: true

require 'plug_thumbnailer/image_comparators/base'
require 'plug_thumbnailer/image_comparators/size'

module PlugThumbnailer
  class ImageComparator

    attr_reader :image

    def initialize(image)
      @image = image
    end

    def call(other)
      size_comparator.call(other)
    end

    private

    def size_comparator
      ::PlugThumbnailer::ImageComparators::Size.new(image)
    end

  end
end
