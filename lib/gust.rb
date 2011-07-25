require 'pygments'
require 'redcarpet'
require 'RedCloth'

class Gust
  extend Pygments

  class << self

    def parse(code, options = {})
      return plain_text(code) unless options[:filename]

      case options[:filename]
        when /.*\.png$/ then image(options[:url])
        when /.*\.markdown$/, /.*\.md$/ then markdown(code)
        when /.*\.textile$/ then textile(code)
        else highlight(code, options) rescue plain_text(code)
      end

    end

    protected

      def image(src)
        "<div class=\"image\"><img src=\"#{src}\"/></div>\n"
      end

      def markdown(markup)
        "<div class=\"markup\">#{Redcarpet.new(markup).to_html}</div>\n"
      end

      def textile(markup)
        "<div class=\"markup\">#{RedCloth.new(markup).to_html}</div>\n"
      end

      def plain_text(text)
        "<div class=\"highlight\"><pre>#{text}</pre></div>\n"
      end

  end

end
