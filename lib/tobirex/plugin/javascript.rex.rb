#
# DO NOT MODIFY!!!!
# This file is automatically generated by rex 1.0.1
# from lexical definition file "javascript.rex".
#

require 'racc/parser'
#
# $ frex javascript.rex
#
class JavaScriptTokenizer < Racc::Parser
  require 'strscan'

  class ScanError < StandardError ; end

  attr_reader :lineno
  attr_reader :filename

  def scan_setup ; end

  def action &block
    yield
  end

  def scan_str( str )
    scan_evaluate  str
    do_parse
  end

  def load_file( filename )
    @filename = filename
    open(filename, "r") do |f|
      scan_evaluate  f.read
    end
  end

  def scan_file( filename )
    load_file  filename
    do_parse
  end

  def next_token
    @rex_tokens.shift
  end

  def scan_evaluate( str )
    scan_setup
    @rex_tokens = []
    @lineno  =  1
    ss = StringScanner.new(str)
    state = nil
    until ss.eos?
      text = ss.peek(1)
      @lineno  +=  1  if text == "\n"
      case state
      when nil
        case
        when (text = ss.scan(/(\r)?\n/))
           @rex_tokens.push action { [:nl, text, lineno, update(text)] }

        when (text = ss.scan(/[\s]+/))
           @rex_tokens.push action { [:sp, text, lineno, update(text)] }

        when (text = ss.scan(/\/\/.*/))
           @rex_tokens.push action { [:comment, text, lineno, update(text)] }

        when (text = ss.scan(/\/\*[^\*]*(\*+[^\/\*][^\*]*)*\*+\//))
           @rex_tokens.push action { [:comment, text, lineno, update(text)] }

        when (text = ss.scan(/\"([^\\\"]|\\.)*\"/))
           @rex_tokens.push action { [:literal, text, lineno, update(text)] }

        when (text = ss.scan(/\'([^\\\']|\\.)*\'/))
           @rex_tokens.push action { [:literal, text, lineno, update(text)] }

        when (text = ss.scan(/[A-Za-z_$][0-9A-Za-z_]*/))
           @rex_tokens.push action { [is_keyword(text), text, lineno, update(text)] }

        when (text = ss.scan(/[0-9]+/))
           @rex_tokens.push action { [:literal, text, lineno, update(text)] }

        when (text = ss.scan(/\/((\\[^\n\r])|[^\n\r\*\\\/])((\\[^\n\r])|[^\n\r\\\/])*\/[gimy]*/))
           @rex_tokens.push action { [:literal, text, lineno, update(text)] }

        when (text = ss.scan(/(\.|\[|\]|\(|\)|\+\+|--|>>>=|>>>|<<=|>>=|<<|>>|<=|<|>=|>|===|!==|==|!=|!|\^|&&|\|\||\||\?|:|=|\*=|\/=|%=|\+=|&=|-|~|\*|\/|%|\+|&|\^=|\|=|,)/))
           @rex_tokens.push action { [:op, text, lineno, update(text)] }

        when (text = ss.scan(/[\{\}]/))
           @rex_tokens.push action { [:op, text, lineno, update(text)] }

        when (text = ss.scan(/;/))
           @rex_tokens.push action { [:op, text, lineno, update(text)] }

        when (text = ss.scan(/./))
           @rex_tokens.push action { [:punct, text, lineno, update(text)] }

        else
          text = ss.string[ss.pos .. -1]
          raise  ScanError, "can not match: '" + text + "'"
        end  # if

      else
        raise  ScanError, "undefined state: '" + state.to_s + "'"
      end  # case state
    end  # until ss
  end  # def scan_evaluate

  def update(text)
    @offset = 0 unless @offset
    @offset += text.size
    @offset - text.size
  end
  KEYWORDS = %w[abstract boolean break byte case catch char class comment const continue debugger default delete dodouble else enum export extends false final finally float for function goto if implements importin instanceof int interface label long native new null package private protected public return shortstatic super switch synchronized this throw throws transient true try typeof var void volatile while with]
  def is_keyword(text)
    if KEYWORDS.index(text)
      :kw
    else
      :ident
    end
  end
  def next_relevant_token()
    @rex_tokens.each do |t|
      return t unless t[0] == :space
    end
    nil
  end
end # class

