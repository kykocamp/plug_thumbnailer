# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'plug_thumbnailer/version'

Gem::Specification.new do |spec|
  spec.name          = "plug_thumbnailer"
  spec.version       = PlugThumbnailer::VERSION
  spec.authors       = ["Rodrigo Pinheiro Campos"]
  spec.email         = ["rodrigo@rodrigo.campos.com.br"]
  spec.description   = %q{Ruby gem generating preview from URL, such as images, videos and others URLs.}
  spec.summary       = %q{Ruby gem ranking images from a given URL returning an object containing images and website informations.}
  spec.homepage      = "https://github.com/kykocamp/plug_thumbnailer"

  spec.files         = `git ls-files`.split($\)
  spec.executables   = spec.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport',          '>= 3.0'
  spec.add_dependency 'json',                   ['>= 1.7.7']
  spec.add_dependency 'rake',                   ['>= 0.9']
  spec.add_dependency 'nokogiri',               '>= 1.6'
  spec.add_dependency 'net-http-persistent',    '>= 2.9'
  spec.add_dependency 'video_info',             '>= 2.6'
  spec.add_dependency 'image_info',             '>= 1.0'
end
