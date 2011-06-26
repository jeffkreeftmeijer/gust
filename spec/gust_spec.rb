$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'gust'

describe Gust do
  
  describe '.parse' do
    
    context 'when only passing "foo" as a string' do
      
      subject { Gust.parse('foo') }
      
      it { should == "<div class=\"markup\">foo</div>\n" }
      
    end
    
    context 'with an unknown filename' do
      
      subject { Gust.parse('foo', :filename => 'foo.bar') }
      
      it { should == "<div class=\"markup\">foo</div>\n" }
      
    end
    
    context 'with a ruby file' do
      
      subject { Gust.parse('foo', :filename => 'foo.rb') }
      
      it { should == "<div class=\"highlight\"><pre><span class=\"n\">foo</span>\n</pre>\n</div>\n" }
      
    end
    
    context 'with a markdown file' do
      
      subject { Gust.parse('*foo*', :filename => 'foo.markdown') }
      
      it { should == "<div class=\"markup\"><p><em>foo</em></p>\n</div>\n" }
      
    end
    
    context 'with a textile file' do
      
      subject { Gust.parse('*foo*', :filename => 'foo.textile') }
      
      it { should == "<div class=\"markup\"><p><strong>foo</strong></p></div>\n" }
      
    end
    
  end
  
end