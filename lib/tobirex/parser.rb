#!/usr/bin/env ruby

require "cgi"
require 'tobirex/plugin/javascript.rex.rb'

module Tobirex
  class Parser

    def initialize(lang = :javascript)
      # TODO pluggable language
      @rexer = JavaScriptTokenizer.new
      self
    end

    def parse(text)
      @rexer.scan_evaluate text
      self
    end

    def each_token
      while t = @rexer.next_token
        yield t
      end
    end

    def print
      puts xml
      self
    end

    def xml
      xml = '<?xml version="1.0"?>'
      xml.concat("<tokens>")
      each_token do |t|
        tag = t[0].to_s
        xml.concat("<#{tag}>#{CGI.escapeHTML(t[1])}</#{tag}>")
      end
      xml.concat("</tokens>")
    end

    def run(argf = ARGF)
      parse(argf.read).print
      self
    end
  end
end

if __FILE__ == $0
  Tobirex::Parser.new.run
end

