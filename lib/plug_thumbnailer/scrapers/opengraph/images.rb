# frozen_string_literal: true

require 'plug_thumbnailer/scrapers/opengraph/base'
require 'plug_thumbnailer/scrapers/opengraph/image'

module PlugThumbnailer
  module Scrapers
    module Opengraph
      class Images < ::PlugThumbnailer::Scrapers::Opengraph::Base

        def call(attribute_name)
          ::PlugThumbnailer::Scrapers::Opengraph::Image.new(document, website).call('image')
        end

      end
    end
  end
end
