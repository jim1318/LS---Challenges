# med1_pig_latin

class PigLatin
  CONSONANT = /[bcdfghjklmnpqrstuvwxyz]/
  VOWEL = /[aeiou]/

  def self.translate(words)
    words.downcase.split(' ').map { |word| latinize(word)}.join(' ')
  end

  def self.latinize(word)
    return word << "ay" if word[0] =~ VOWEL
    return word[3..-1] << word[0..2] << "ay" if word[1..2] =~ /(qu)/
    return word[3..-1] << word[0..2] << "ay" if word[0..2] =~ /(sch|thr)/
    return word[2..-1] << word[0..1] << "ay" if word[0..1] =~ /(qu|ch|th)/
    return word << "ay" if (word[0] == 'x' || word[0] == 'y') && word[1] =~ CONSONANT
    return word[1..-1] << word[0] << "ay" if (word[0] == 'x' || word[0] == 'y') && word[1] =~ VOWEL
    return word[1..-1] << word[0] << "ay"
  end
end

require 'minitest/autorun'

class PigLatinTest < Minitest::Test
  def test_word_beginning_with_a
    assert_equal 'appleay', PigLatin.translate('apple')
  end

  def test_other_word_beginning_e
    assert_equal 'earay', PigLatin.translate('ear')
  end

  def test_word_beginning_with_p
    assert_equal 'igpay', PigLatin.translate('pig')
  end

  def test_word_beginning_with_k
    assert_equal 'oalakay', PigLatin.translate('koala')
  end

  def test_word_beginning_with_ch
    assert_equal 'airchay', PigLatin.translate('chair')
  end

  def test_word_beginning_with_qu
    assert_equal 'eenquay', PigLatin.translate('queen')
  end

  def test_word_with_consonant_preceding_qu
    assert_equal 'aresquay', PigLatin.translate('square')
  end

  def test_word_beginning_with_th
    assert_equal 'erapythay', PigLatin.translate('therapy')
  end

  def test_word_beginning_with_thr
    assert_equal 'ushthray', PigLatin.translate('thrush')
  end

  def test_word_beginning_with_sch
    assert_equal 'oolschay', PigLatin.translate('school')
  end

  def test_translates_phrase
    assert_equal 'ickquay astfay unray', PigLatin.translate('quick fast run')
  end

  def test_word_beginning_with_ye
    assert_equal 'ellowyay', PigLatin.translate('yellow')
  end

  def test_word_beginning_with_yt
    assert_equal 'yttriaay', PigLatin.translate('yttria')
  end

  def test_word_beginning_with_xe
    assert_equal 'enonxay', PigLatin.translate('xenon')
  end

  def test_word_beginning_with_xr
    assert_equal 'xrayay', PigLatin.translate('xray')
  end
end
