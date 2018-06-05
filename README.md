# PlugThumbnailer

Ruby gem generating image thumbnails from a given URL. Rank them and give you back an object containing images and website informations. Works like Facebook link previewer.

## Features

- Dead simple.
- Support [OpenGraph](http://ogp.me/) protocol.
- Find and sort images that best represent what the page is about.
- Find and rate description that best represent what the page is about.
- Allow for custom class to sort the website descriptions yourself.
- Support image urls blacklisting (advertisements).
- Works with and without Rails.
- Fully customizable.
- Fully tested.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'plug_thumbnailer'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plug_thumbnailer

Run:

	$ rails g plug_thumbnailer:install

This will add `plug_thumbnailer.rb` to `config/initializers/`.

## Usage

Run `irb` and require the gem:

```ruby
require 'plug_thumbnailer'
```

The gem handle regular website but also website that use the [Opengraph](http://ogp.me/) protocol.

```ruby
object = PlugThumbnailer.generate('http://stackoverflow.com')
 => #<PlugThumbnailer::Models::Website:...>

object.title
 => "Stack Overflow"

object.favicon
 => "//cdn.sstatic.net/stackoverflow/img/favicon.ico?v=038622610830"

object.description
 => "Q&A for professional and enthusiast programmers"

object.images.first.src.to_s
 => "http://cdn.sstatic.net/stackoverflow/img/apple-touch-icon@2.png?v=fde65a5a78c6"
```

PlugThumbnailer `generate` method return an instance of `PlugThumbnailer::Models::Website` that respond to `to_json` and `as_json` as you would expect:

```ruby
object.to_json
 => "{\"url\":\"http://stackoverflow.com\",\"title\":\"Stack Overflow\",\"description\":\"Q&A for professional and enthusiast programmers\",\"images\":[{\"src\":\"http://cdn.sstatic.net/stackoverflow/img/apple-touch-icon@2.png?v=fde65a5a78c6\",\"size\":[316,316],\"type\":\"png\"}]}"
```


## Configuration

PlugThumbnailer comes with default configuration values. You can change default value by overriding them in a rails initializer:

In `config/initializers/plug_thumbnailer.rb`

```ruby
PlugThumbnailer.configure do |config|
  # Numbers of redirects before raising an exception when trying to parse given url.
  #
  # config.redirect_limit = 3

  # Set user agent
  #
  # config.user_agent = 'plug_thumbnailer'

  # Enable or disable SSL verification
  #
  # config.verify_ssl = true

  # The amount of time in seconds to wait for a connection to be opened.
  # If the HTTP object cannot open a connection in this many seconds,
  # it raises a Net::OpenTimeout exception.
  #
  # See http://www.ruby-doc.org/stdlib-2.1.1/libdoc/net/http/rdoc/Net/HTTP.html#open_timeout
  #
  # config.http_open_timeout = 5

  # List of blacklisted urls you want to skip when searching for images.
  #
  # config.blacklist_urls = [
  #   %r{^http://ad\.doubleclick\.net/},
  #   %r{^http://b\.scorecardresearch\.com/},
  #   %r{^http://pixel\.quantserve\.com/},
  #   %r{^http://s7\.addthis\.com/}
  # ]

  # List of attributes you want PlugThumbnailer to fetch on a website.
  #
  # config.attributes = [:title, :images, :description, :videos, :favicon]

  # List of procedures used to rate the website description. Add you custom class
  # here. See wiki for more details on how to build your own graders.
  #
  # config.graders = [
  #   ->(description) { ::PlugThumbnailer::Graders::Length.new(description) },
  #   ->(description) { ::PlugThumbnailer::Graders::HtmlAttribute.new(description, :class) },
  #   ->(description) { ::PlugThumbnailer::Graders::HtmlAttribute.new(description, :id) },
  #   ->(description) { ::PlugThumbnailer::Graders::Position.new(description, weight: 3) },
  #   ->(description) { ::PlugThumbnailer::Graders::LinkDensity.new(description) }
  # ]

  # Minimum description length for a website.
  #
  # config.description_min_length = 25

  # Regex of words considered positive to rate website description.
  #
  # config.positive_regex = /article|body|content|entry|hentry|main|page|pagination|post|text|blog|story/i

  # Regex of words considered negative to rate website description.
  #
  # config.negative_regex = /combx|comment|com-|contact|foot|footer|footnote|masthead|media|meta|outbrain|promo|related|scroll|shoutbox|sidebar|sponsor|shopping|tags|tool|widget|modal/i

  # Numbers of images to fetch. Fetching too many images will be slow.
  # Note that PlugThumbnailer will only sort fetched images between each other.
  # Meaning that they could be a "better" image on the page.
  #
  # config.image_limit = 5

  # Whether you want PlugThumbnailer to return image size and type or not.
  # Setting this value to false will increase performance since for each images, PlugThumbnailer
  # does not have to fetch its size and type.
  #
  # config.image_stats = true
  #
  # Whether you want PlugThumbnailer to raise an exception if the Content-Type of the HTTP request
  # is not an html or xml.
  #
  # config.raise_on_invalid_format = false
  #
  # Sets number of concurrent http connections that can be opened to fetch images informations such as size and type.
  #
  # config.max_concurrency = 20

  # Sets the default encoding.
  #
  # config.encoding = 'utf-8'
end
```

Or at runtime:

```ruby
object = PlugThumbnailer.generate('http://stackoverflow.com', redirect_limit: 5, user_agent: 'foo')
```

Note that runtime options will override default global configuration.

See [Configuration Options Explained](https://github.com/kykocamp/plug_thumbnailer/wiki/Configuration-options-explained) for more details on each configuration options.

## Exceptions

PlugThumbnailer defines a list of custom exceptions you may want to rescue in your code. All the following exceptions inherit from `PlugThumbnailer::Exceptions`:

* `RedirectLimit` -- raised when redirection threshold defined in config is reached
* `BadUriFormat` -- raised when url given is not a valid HTTP url
* `FormatNotSupported` -- raised when the `Content-Type` of the HTTP request is not supported (not `html`)

You can rescue from any PlugThumbnailer exceptions using the following code:

```ruby
begin
  PlugThumbnailer.generate('http://foo.com')
rescue PlugThumbnailer::Exceptions => e
  # do something
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Run the specs (`bundle exec rspec spec`)
4. Commit your changes (`git commit -am 'Added some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new Pull Request
