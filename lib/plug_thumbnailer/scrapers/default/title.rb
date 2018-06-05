# frozen_string_literal: true

require 'plug_thumbnailer/scrapers/default/base'

module PlugThumbnailer
  module Scrapers
    module Default
      class Title < ::PlugThumbnailer::Scrapers::Default::Base

        def value
          model.to_s
        end

        private

        def model
          modelize(node)
        end

        def node
          document.css(attribute_name)
        end

      end
    end
  end
end
