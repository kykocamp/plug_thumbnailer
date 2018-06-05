# frozen_string_literal: true

require 'json'
require 'plug_thumbnailer/version'
require 'plug_thumbnailer/configuration'
require 'plug_thumbnailer/exceptions'
require 'plug_thumbnailer/page'

module PlugThumbnailer

  class << self
    attr_reader :page

    def generate(url, options = {})
      @page = ::PlugThumbnailer::Page.new(url, options)

      page.generate
    end

  end

end

begin
  require 'rails'
rescue LoadError
end

$stderr.puts <<-EOC if !defined?(Rails)
warning: no framework detected.
Your Gemfile might not be configured properly.
---- e.g. ----
Rails:
    gem 'plug_thumbnailer'
EOC