# frozen_string_literal: true

require 'plug_thumbnailer/model'
require 'plug_thumbnailer/image_parser'
require 'plug_thumbnailer/image_comparator'
require 'plug_thumbnailer/image_validator'

module PlugThumbnailer
  module Models
    class Image < ::PlugThumbnailer::Model

      attr_reader :src, :type, :size

      def initialize(src, size = nil, type = nil)
        @src  = squish src
        @size = size || parser.size
        @type = type || parser.type
      end

      def to_s
        src.to_s
      end

      def <=>(other)
        comparator.call(other)
      end

      def valid?
        validator.call
      end

      def as_json(*)
        {
          src:  src.to_s,
          size: size,
          type: type
        }
      end

      private

      def squish str
        str.squish
      rescue
        str
      end

      def parser
        @parser ||= ::PlugThumbnailer::ImageParser.new(src)
      end

      def validator
        ::PlugThumbnailer::ImageValidator.new(self)
      end

      def comparator
        ::PlugThumbnailer::ImageComparator.new(self)
      end

    end
  end
end
