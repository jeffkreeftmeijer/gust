require 'pygments'
require 'kramdown'
require 'RedCloth'

class Gust

  def self.parse(code, options = {})

    if options[:filename]
      code = case options[:filename]
        when /.*\.markdown$/, /.*\.md$/ then Kramdown::Document.new(code).to_html
        when /.*\.textile$/ then RedCloth.new(code).to_html
        else return Pygments.highlight(code, options) rescue code
      end
    end

    "<div class=\"markup\">#{code}</div>\n"
  end

end
