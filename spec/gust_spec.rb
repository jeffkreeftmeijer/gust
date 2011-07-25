$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'gust'

describe Gust do

  shared_examples_for 'a markdown file' do

    it { should == "<div class=\"markup\"><p><em>foo</em></p>\n</div>\n" }

  end

  describe '.parse' do

    context 'when only passing "foo" as a string' do

      subject { Gust.parse('foo') }

      it { should == "<div class=\"highlight plain\"><pre>foo</pre></div>\n" }

    end

    context 'with an unknown filename' do

      subject { Gust.parse('foo', :filename => 'foo.bar') }

      it { should == "<div class=\"highlight plain\"><pre>foo</pre></div>\n" }

    end

    context 'with a ruby file' do

      subject { Gust.parse('foo', :filename => 'foo.rb') }

      it { should == "<div class=\"highlight\"><pre><span class=\"n\">foo</span>\n</pre>\n</div>\n" }

    end

    context 'with a markdown file' do

      subject { Gust.parse('*foo*', :filename => 'foo.markdown') }

      it_should_behave_like 'a markdown file'

      context 'with a Github inline code block' do

        subject { Gust.parse("``` ruby\nfoo\n```", :filename => 'foo.md') }

        it { should == "<div class=\"markup\"><div class=\"highlight\"><pre><span class=\"n\">foo</span>\n</pre>\n</div>\n\n</div>\n" }

      end

      context 'when using the (wrong) .md extension' do

        subject { Gust.parse('*foo*', :filename => 'foo.md') }

        it_should_behave_like 'a markdown file'

      end

    end

    context 'with a textile file' do

      subject { Gust.parse('*foo*', :filename => 'foo.textile') }

      it { should == "<div class=\"markup\"><p><strong>foo</strong></p></div>\n" }

    end

    context 'with a .png file' do
      subject { Gust.parse('', :filename => 'foo.png', :url => 'http://jeffkreeftmeijer.com/images/carnivore_capybara.png') }

      it { should == "<div class=\"image\"><img src=\"http://jeffkreeftmeijer.com/images/carnivore_capybara.png\"/></div>\n" }

    end

  end

end