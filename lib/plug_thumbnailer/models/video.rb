# frozen_string_literal: true

require 'plug_thumbnailer/model'
require 'plug_thumbnailer/video_parser'

module PlugThumbnailer
  module Models
    class Video < ::PlugThumbnailer::Model

      attr_reader :src, :size, :duration, :provider, :id, :embed_code

      def initialize(src, size = nil)
        @src        = src
        @id         = parser.id
        @size       = size || parser.size
        @duration   = parser.duration
        @provider   = parser.provider
        @embed_code = parser.embed_code
      end

      def to_s
        src.to_s
      end

      def as_json(*)
        {
          id:         id,
          src:        src.to_s,
          size:       size,
          duration:   duration,
          provider:   provider,
          embed_code: embed_code
        }
      end

      private

      def parser
        @parser ||= ::PlugThumbnailer::VideoParser.new(self)
      end

    end
  end
end
