#!/usr/bin/env ruby -Ku

require 'rubygems'
require 'cgi'
require 'tobirex'
require 'rexml/document'

#
# colorize.rb
#   output colorized HTML
# Usage:
#   $ruby colorize.rb test.js > test.js.html
#

module Tobirex
  class Colorize
    TEMPLATE = <<HTML
<html>
<head>
<style type="text/css">
.kw { color : blue; }
.comment { color : green; }
.literal { color : red; }
</style>
</head>
<body>
%s
</body>
</html>
HTML

    def run(argf = ARGF)
      xml = Tobirex::Parser.new(:javascript).parse(argf.read).xml
      doc = REXML::Document.new(xml)
      html = "<pre class=\"code\">"
      doc.root.each do |token|
        html.concat("<span class=\"#{token.name}\">#{CGI.escapeHTML(token.text)}</span>")
      end
      html.concat("</pre>")
      puts Colorize::TEMPLATE.sub("%s", html)
    end
  end
end

if $0 == __FILE__
  Tobirex::Colorize.new.run
end
