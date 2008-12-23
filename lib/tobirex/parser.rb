#!/usr/bin/env ruby

require 'tobirex/plugin/javascript.rex.rb'

module Tobirex
  class Parser

    def initialize(lang)
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
      while t = @rexer.next_token
        p t
      end
      self
    end

    def run(argf = ARGF)
      parse(ARGF.read).print
    end
  end
end

if __FILE__ == $0
  Tobirex::Parser.new(:javascript).run
end

