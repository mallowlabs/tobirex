#!/usr/bin/env ruby
$LOAD_PATH << File.expand_path(File.dirname(__FILE__) + "/../lib")
require 'tobirex'
require 'test/unit'
begin
require 'rubygems'
require 'redgreen'
rescue LoadError
end

#TODO write tests
class TobirexParserTest < Test::Unit::TestCase
  def setup
    @parser = Tobirex::Parser.new(:javascript)
  end

  def test_parse
    @parser.parse("var i = 0;")
    i = 0
    @parser.each_token do |t|
      i += 1
    end
    assert i == 8
  end

  def test_xml
    @parser.parse <<EOF
var i = 1;
var str = "";
for (i = 0; i < 10; i++) {
    str += "<hoge>";
}
document.write(str);
EOF
    @parser.print
  end

  def test_minus_literal
    @parser.parse("-2")
    i = 0
    @parser.each_token do |t|
      i += 1
    end
    assert i == 1
  end

  def test_float_literal
    @parser.parse("-2.0")
    i = 0
    @parser.each_token do |t|
      i += 1
    end
    assert i == 1
   end

  def teardown
  end
end

