# カラオケにはキーを変える機能があります。
# +1するとキーが1つ上がります。
# -1するとキーが1つ下がります。


# たとえば「ドレミファソ」というメロディのキーを2つ上げると「レミファ#ソラ」になります。


# 「ド」が「レ」に変わった理由はピアノの鍵盤を見るとわかります。


# f:id:JunichiIto:20180715103552j:plain
# http://mids-player.net/_src/sc219/7208CAE94D589B98AK955C.jpg


# ドの2つ右隣にある鍵盤の音はレになっていますね。(ド → ド# → レ)


# 他の音も同様です。
# 例えば「ミ」の音が「ファ#」に変わったのも、「ミ → ファ → ファ#」になったためです。

# 「ドレミファソ」のようにカタカナだとプログラムで扱いづらいので、英語の読み方、つまりアルファベットに置き換えましょう。


# ドレミファソ → CDEFG
# レミファ#ソラ → DEF#GA


# みなさんに作成してもらうのは、このように元のメロディを自由に上げたり下げたりするプログラムです。

# かえるのうたのメロディは以下のような文字列で表現されます。

# "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "

# このクラスの使用例を以下に示します。

# melody = "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
# karaoke = KaraokeMachine.new(melody)
# karaoke.transpose(2)
# # => "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "
# karaoke.transpose(-1)
# # => "B C# D# E |D# C# B   |D# E F# G# |F# E D#   |B   B   |B   B   |BBC#C#D#D#EE|D# C# B   "

# # 1オクターブ(12音)以上変えることもできる
# karaoke.transpose(12)
# # => "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
# karaoke.transpose(14)
# # => "D E F# G |F# E D   |F# G A B |A G F#   |D   D   |D   D   |DDEEF#F#GG|F# E D   "

# # ド以外の音から始まるメロディを使う場合もある
# melody = "F# G# A# B |A# G# F#   |A# B C# D# |C# B A#   |F#   F#   |F#   F#   |F#F#G#G#A#A#BB|A# G# F#   "
# karaoke = KaraokeMachine.new(melody)
# karaoke.transpose(6)
# # => "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
# karaoke.transpose(-6)
# # => "C D E F |E D C   |E F G A |G F E   |C   C   |C   C   |CCDDEEFF|E D C   "
# さあ、KaraokeMachineクラスを実装してみましょう！

class KaraokeMachine
    def initialize(melody)
      @melody=melody.reverse
    end
  
    def transpose(key)
      keys = %w(C C# D D# E F F# G G# A A# B)
      downkey = key % (-12)                     # keyを(-12)で割った余りを持つことで、
      newmelody=""                              # キーの変換を引き算で行うことができる
      pre=""
      flg = false
      @melody.each_char do |m|                  # メロディーを後ろから1文字ずつ見ていく
        if m=='#'                               # '#'が現れたらその次の一文字と連結させる
          flg = true
          next
        end
        if flg
          m=m+'#'
          flg =false
        end
        if keys.include?(m)                     # 文字列mがキーを表していたら、キーを変換する
          newkey = keys.index(m)+downkey
          newmelody = keys[newkey] + newmelody
        else                                    # 文字列mがキーで無ければそのまま
          newmelody = m + newmelody
        end
      end

      return newmelody
    end
end
