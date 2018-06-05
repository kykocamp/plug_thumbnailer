# frozen_string_literal: true

require 'plug_thumbnailer/scrapers/opengraph/base'
require 'plug_thumbnailer/uri'

module PlugThumbnailer
  module Scrapers
    module Opengraph
      class Image < ::PlugThumbnailer::Scrapers::Opengraph::Base

        def value
          ::PlugThumbnailer::Scrapers::Opengraph::Image::Base.new(document, website).value +
          ::PlugThumbnailer::Scrapers::Opengraph::Image::Url.new(document, website).value
        end

        private

        # Handles `og:image` attributes.
        class Base < ::PlugThumbnailer::Scrapers::Opengraph::Base

          def value
            model
          end

          def model
            nodes.map do |n|
              uri =  PlugThumbnailer::URI.new(n.attributes['content'])
              modelize(n, uri.to_s) if uri.valid?
            end.compact
          end

          def modelize(node, text = nil)
            model_class.new(text, size)
          end

          def model_class
            ::PlugThumbnailer::Models::Image
          end

          def nodes
            nodes = meta_xpaths(attribute: attribute)
            nodes.empty? ? meta_xpaths(attribute: attribute, key: :name) : nodes
          end

          def attribute
            'og:image'
          end

          def size
            [width.to_i, height.to_i] if width && height
          end

          def width
            ::PlugThumbnailer::Scrapers::Opengraph::Image::Width.new(document).value
          end

          def height
            ::PlugThumbnailer::Scrapers::Opengraph::Image::Height.new(document).value
          end

        end

        # Handles `og:image:url` attributes.
        class Url < ::PlugThumbnailer::Scrapers::Opengraph::Image::Base

          private

          def attribute
            'og:image:url'
          end

        end

        # Handles `og:image:width` attributes.
        class Width < ::PlugThumbnailer::Scrapers::Opengraph::Base

          def value
            node.attributes['content'].to_s if node
          end

          private

          def attribute
            'og:image:width'
          end

        end

        # Handles `og:image:height` attributes.
        class Height < ::PlugThumbnailer::Scrapers::Opengraph::Base

          def value
            node.attributes['content'].to_s if node
          end

          private

          def attribute
            'og:image:height'
          end

        end

      end
    end
  end
end
