# frozen_string_literal: true

require 'delegate'
require 'plug_thumbnailer/graders/base'
require 'plug_thumbnailer/graders/length'
require 'plug_thumbnailer/graders/html_attribute'
require 'plug_thumbnailer/graders/link_density'
require 'plug_thumbnailer/graders/position'

module PlugThumbnailer
  class Grader < ::SimpleDelegator

    attr_reader :config, :description

    def initialize(description)
      @config      = ::PlugThumbnailer.page.config
      @description = description

      super(config)
    end

    # For given description, computes probabilities returned by each graders by multipying them together.
    #
    # @return [Float] the probability for the given description to be considered good
    def call
      probability = 1.0

      graders.each do |lambda|
        instance = lambda.call(description)
        probability *= instance.call.to_f ** instance.weight
      end

      probability
    end

    private

    def graders
      config.graders
    end

  end
end
