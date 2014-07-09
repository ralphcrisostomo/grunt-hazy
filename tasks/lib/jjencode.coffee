###
 * grunt-hazy
 * https:#github.com/ralphcrisostomo/grunt-hazy
 *
 * Copyright (c) 2014 Ralph Crisostomo
 * Licensed under the MIT license.
###

# ----------
# CLASS
# ----------
module.exports = class JJEncode

  # From: http:#utf-8.jp/public/jjencode.html
  # jshint eqeqeq:false, curly:false, asi:true, loopfunc:true *
  constructor: () ->
    @b = [ "___", "__$", "_$_", "_$$", "$__", "$_$", "$$_", "$$$", "$___", "$__$", "$_$_", "$_$$", "$$__", "$$_$", "$$$_", "$$$$", ]


  jjencode: (gv, string) ->
    r = ''
    s = ''
    n = ''
    for i in [0...string.length]
      n = string.charCodeAt( i )
      if n is 0x22 or n is 0x5c
        s += "\\\\\\#{string.charAt( i ).toString(16)}"
      else if (0x21 <= n && n <= 0x2f) or (0x3A <= n && n <= 0x40) or ( 0x5b <= n && n <= 0x60 ) or ( 0x7b <= n && n <= 0x7f )
        s += string.charAt( i )
      else if (0x30 <= n && n <= 0x39 ) or (0x61 <= n && n <= 0x66 )
        if s then r += "\"#{s}\"+"
        r += "#{gv}.#{@b[ if n < 0x40 then n - 0x30 else n - 0x57 ]}+"
        s=""
      else if( n is 0x6c ) # 'l'
          if s then r += "\"#{s}\"+"
          r += "(![]+\"\")[#{gv}._$_]+"
          s = ""
      else if( n is 0x6f ) # 'o'
          if s then r += "\"#{s}\"+"
          r += "#{gv}._$+"
          s = ""
      else if( n is 0x74 ) # 'u'
          if s then r += "\"#{s}\"+"
          r += "#{gv}.__+"
          s = ""
      else if( n is 0x75 ) # 'u'
          if s then r += "\"#{s}\"+"
          r += "#{gv}.__+"
          s = ""
      else if ( n < 128 )
          if s then r += "\"#{s}" else r += "\""
          r += "\\\\\"+" + n.toString(8).replace( /[0-7]/g, (c) => return "#{gv}.#{@b[c]}+" )
          s = ""
      else
          if s then r += "\"#{s}" else r += "\""
          r += "\\\\\"+#{gv}._+" + n.toString(16).replace( /[0-9a-f]/gi, (c) => "#{gv}.#{@b[parseInt(c,16)]}+" )
          s = ""
    if s then r += "\"#{s}\"+"

    @getEncoded(gv, r)

  getEncoded: (gv, r) ->
    r =
    "#{gv}=~[];" +
    "#{gv}={___:++#{gv},$$$$:(![]+\"\")[#{gv}],__$:++#{gv},$_$_:(![]+\"\")[#{gv}],_$_:++" +
    "#{gv},$_$$:({}+\"\")[#{gv}],$$_$:(#{gv}[#{gv}]+\"\")[#{gv}],_$$:++#{gv},$$$_:(!\"\"+\"\")" +
    "[#{gv}],$__:++#{gv},$_$:++#{gv},$$__:({}+\"\")[#{gv}],$$_:++#{gv},$$$:++#{gv},$___:++#{gv},$__$:++#{gv}};" +
    "#{gv}.$_=" +
    "(#{gv}.$_=#{gv}+\"\")[#{gv}.$_$]+" +
    "(#{gv}._$=#{gv}.$_[#{gv}.__$])+" +
    "(#{gv}.$$=(#{gv}.$+\"\")[#{gv}.__$])+"+
    "((!#{gv})+\"\")[#{gv}._$$]+" +
    "(#{gv}.__=#{gv}.$_[#{gv}.$$_])+" +
    "(#{gv}.$=(!\"\"+\"\")[#{gv}.__$])+" +
    "(#{gv}._=(!\"\"+\"\")[#{gv}._$_])+" +
    "#{gv}.$_[#{gv}.$_$]+" +
    "#{gv}.__+" +
    "#{gv}._$+" +
    "#{gv}.$;" +
    "#{gv}.$$=" +
    "#{gv}.$+" +
    "(!\"\"+\"\")[#{gv}._$$]+" +
    "#{gv}.__+" +
    "#{gv}._+" +
    "#{gv}.$+" +
    "#{gv}.$$;" +
    "#{gv}.$=(#{gv}.___)[#{gv}.$_][#{gv}.$_];" +
    "#{gv}.$(#{gv}.$(#{gv}.$$+\"\\\"\"+" + r + "\"\\\"\")())();"
    r




