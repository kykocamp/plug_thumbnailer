# frozen_string_literal: true

module PlugThumbnailer
  module Generators
    class InstallGenerator < ::Rails::Generators::Base

      source_root File.expand_path('../../templates', __FILE__)

      desc 'Creates a PlugThumbnailer initializer for your application.'

      def copy_initializer
        template 'initializer.rb', 'config/initializers/plug_thumbnailer.rb'
      end

    end
  end
end
