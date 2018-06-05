# frozen_string_literal: true

require 'plug_thumbnailer/scrapers/opengraph/base'
require 'plug_thumbnailer/scrapers/opengraph/video'

module PlugThumbnailer
  module Scrapers
    module Opengraph
      class Videos < ::PlugThumbnailer::Scrapers::Opengraph::Base

        def call(attribute_name)
          ::PlugThumbnailer::Scrapers::Opengraph::Video.new(document, website).call('video')
        end

      end
    end
  end
end
