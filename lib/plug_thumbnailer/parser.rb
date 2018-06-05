# frozen_string_literal: true

require 'nokogiri'

module PlugThumbnailer
  class Parser

    def call(source)
      ::Nokogiri::HTML(source, nil, PlugThumbnailer.page.config.encoding)
    rescue ::Nokogiri::XML::SyntaxError => e
      raise ::PlugThumbnailer::SyntaxError.new(e.message)
    end

  end
end
