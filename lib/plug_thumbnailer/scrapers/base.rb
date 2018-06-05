# frozen_string_literal: true

require 'delegate'
require 'plug_thumbnailer/models/title'
require 'plug_thumbnailer/models/description'
require 'plug_thumbnailer/models/image'
require 'plug_thumbnailer/models/video'

module PlugThumbnailer
  module Scrapers
    class Base < ::SimpleDelegator

      attr_reader :config, :document, :website, :attribute_name

      def initialize(document, website = nil)
        @config   = ::PlugThumbnailer.page.config
        @document = document
        @website  = website

        super(config)
      end

      def call(attribute_name)
        return false unless website.present?
        return false unless applicable?

        @attribute_name = attribute_name

        website.send("#{attribute_name}=", value)
        website
      end

      def applicable?
        true
      end

      def value
        fail NotImplementedError
      end

      private

      def meta_xpath(options = {})
        meta_xpaths(options).first
      end

      def meta_xpaths(options = {})
        key       = options.fetch(:key, :property)
        value     = options.fetch(:value, :content)
        attribute = options.fetch(:attribute, attribute_name)

        document.xpath("//meta[translate(@#{key},'#{abc.upcase}','#{abc}') = '#{attribute}' and string-length(@#{value}) > 0]")
      end

      def abc
        'abcdefghijklmnopqrstuvwxyz'
      end

      def model_class
        "::PlugThumbnailer::Models::#{attribute_name.to_s.camelize}".constantize
      end

      def modelize(node, text = nil)
        model_class.new(node, text)
      end

    end
  end
end
