require 'pygments'
require 'kramdown'
require 'RedCloth'

class Gust

  def self.parse(code, options = {})
    return "<div class=\"highlight\"><pre>#{code}</pre></div>\n" unless options[:filename]

    case options[:filename]
      when /.*\.png$/ then "<div class=\"image\"><img src=\"#{options[:url]}\"/></div>\n"
      when /.*\.markdown$/, /.*\.md$/ then "<div class=\"markup\">#{Kramdown::Document.new(code).to_html}</div>\n"
      when /.*\.textile$/ then "<div class=\"markup\">#{RedCloth.new(code).to_html}</div>\n"
      else Pygments.highlight(code, options) rescue "<div class=\"markup\">#{code}</div>\n"
    end

  end

end
