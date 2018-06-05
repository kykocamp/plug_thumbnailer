# frozen_string_literal: true

require 'plug_thumbnailer/model'
require 'plug_thumbnailer/grader'

module PlugThumbnailer
  module Models
    class Description < ::PlugThumbnailer::Model

      attr_reader   :node, :text, :position, :candidates_number
      attr_accessor :probability

      def initialize(node, text, position = 1, candidates_number = 1)
        @node              = node
        @text              = sanitize(text)
        @position          = position
        @candidates_number = candidates_number
        @probability       = compute_probability
      end

      def to_s
        text
      end

      def <=>(other)
        probability <=> other.probability
      end

      private

      def compute_probability
        ::PlugThumbnailer::Grader.new(self).call
      end

    end
  end
end
