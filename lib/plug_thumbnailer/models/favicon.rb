# frozen_string_literal: true

require 'plug_thumbnailer/model'

module PlugThumbnailer
  module Models
    class Favicon < ::PlugThumbnailer::Model

      attr_reader :uri

      def initialize(uri)
        @uri = uri
      end

      def to_s
        uri.to_s
      end

      def as_json(*)
        {
          src: to_s
        }
      end

    end
  end
end
