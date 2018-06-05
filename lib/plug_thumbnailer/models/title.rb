# frozen_string_literal: true

require 'plug_thumbnailer/model'

module PlugThumbnailer
  module Models
    class Title < ::PlugThumbnailer::Model

      attr_reader :node, :text

      def initialize(node, text = nil)
        @node = node
        @text = sanitize(text || node.text)
      end

      def to_s
        text
      end

    end
  end
end
