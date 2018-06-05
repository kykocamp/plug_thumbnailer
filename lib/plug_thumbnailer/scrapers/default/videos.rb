# frozen_string_literal: true

require 'plug_thumbnailer/scrapers/default/base'
require 'plug_thumbnailer/models/video'

module PlugThumbnailer
  module Scrapers
    module Default
      class Videos < ::PlugThumbnailer::Scrapers::Default::Base

        def value
          nil
        end

      end
    end
  end
end
