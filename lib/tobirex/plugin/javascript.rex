#
# frex javascript.rex
#
class JavaScriptTokenizer
inner
  def update(text)
    @offset = 0 unless @offset
    @offset += text.size
    @offset - text.size
  end

  def is_keyword(text)
    keywords = %w[abstract boolean break byte case catch char class comment const continue debugger default delete dodouble else enum export extends false final finally float for function goto if implements importin instanceof int interface label long native new null package private protected public return shortstatic super switch synchronized this throw throws transient true try typeof var void volatile while with]

    if keywords.index(text)
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
    
macro
  slash           \/
  star            \*
  nonstar         [^\*]
  nonslashstar    [^\/\*]
  commentcontent  {star}+{nonslashstar}{nonstar}*
  comment         {slash}{star}{nonstar}*({commentcontent})*{star}+{slash}
  operator        (\.|\[|\]|\(|\)|\+\+|--|>>>=|>>>|<<=|>>=|<<|>>|<=|<|>=|>|===|!==|==|!=|!|\^|&&|\|\||\||\?|:|=|\*=|\/=|%=|\+=|&=|-|~|\*|\/|%|\+|&|\^=|\|=|,)
  backslash_sequence (\\[^\n\r])
  regexp_first    ({backslash_sequence}|[^\n\r\*\\\/])
  regexp_char     ({backslash_sequence}|[^\n\r\\\/])
  regexp_body     {regexp_first}{regexp_char}*
  regexp          \/{regexp_body}\/[gimy]*

rule
  (\r)?\n                    { [:nl, text, lineno, update(text)] }
  [\s]+                      { [:sp, text, lineno, update(text)] }
  \/\/.*                     { [:comment, text, lineno, update(text)] }
  {comment}                  { [:comment, text, lineno, update(text)] }
  \"([^\\\"]|\\.)*\"         { [:string, text, lineno, update(text)] }
  \'([^\\\']|\\.)*\'         { [:string, text, lineno, update(text)] }
  [A-Za-z_$][0-9A-Za-z_]*     { [is_keyword(text), text, lineno, update(text)] }
  [0-9]+                     { [:literal, text, lineno, update(text)] }
  \/((\\[^\n\r])|[^\n\r\*\\\/])((\\[^\n\r])|[^\n\r\\\/])*\/[gimy]* { [:regexp, text, lineno, update(text)] }
  {operator}                 { [:op, text, lineno, update(text)] }
#  [\(\)]                     { [:paren, text, lineno, update(text)] }
  [\{\}]                     { [:brace, text, lineno, update(text)] }
  ;                          { [:semi, text, lineno, update(text)] }
  .                          { [:punct, text, lineno, update(text)] }

end

