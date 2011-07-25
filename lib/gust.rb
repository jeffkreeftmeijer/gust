require 'pygments'
require 'redcarpet'
require 'RedCloth'
require 'nokogiri'

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
        inline_highlight(
          "<div class=\"markup\">" <<
          Redcarpet.new(markup, :fenced_code, :gh_blockcode).to_html <<
          "</div>"
        ) << "\n"
      end

      def textile(markup)
        "<div class=\"markup\">#{RedCloth.new(markup).to_html}</div>\n"
      end

      def plain_text(text)
        "<div class=\"highlight plain\"><pre>#{text}</pre></div>\n"
      end

      def inline_highlight(html)
        doc = Nokogiri::HTML(html)
        doc.search("//pre[@lang]").each do |pre|
          pre.replace highlight(pre.text.rstrip, :lexer => pre[:lang])
        end
        doc.xpath('//div[@class="markup"]').to_xml
      end

  end

end
