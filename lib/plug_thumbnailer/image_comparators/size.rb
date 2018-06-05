# frozen_string_literal: true

module PlugThumbnailer
  module ImageComparators
    class Size < ::PlugThumbnailer::ImageComparators::Base

      def call(other)
        (other.size.min.to_i ** 2) <=> (image.size.min.to_i ** 2)
      end

    end
  end
end
