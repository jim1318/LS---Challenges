# protein_translation

class InvalidCodonError < StandardError
end

class Translation
  def self.of_codon(codon)
    case codon
    when 'AUG' then "Methionine"
    when 'UUU', 'UUC' then "Phenylalanine"
    when 'UUA', 'UUG' then "Leucine"
    when 'UCU', 'UCC', 'UCA', 'UCG' then "Serine"
    when 'UAU', 'UAC' then "Tyrosine"
    when 'UGU', 'UGC' then "Cysteine"
    when 'UGG' then "Tryptophan"
    when 'UAA', 'UAG', 'UGA' then "STOP"
    else raise InvalidCodonError
    end
  end

  def self.of_rna(strand)
    codons = []
    loop do 
      break if strand.length == 0
      codons << strand.slice!(0..2)
    end

    instructions = codons.map { |codon| self.of_codon(codon)}
    return instructions[0..(instructions.index('STOP')-1)] if (instructions.index('STOP') != nil) && instructions.length > 1
    instructions
  end
end

require 'minitest/autorun'

# rubocop:disable Style/MethodName
class TranslationTest < Minitest::Test
  def test_AUG_translates_to_methionine
    assert_equal 'Methionine', Translation.of_codon('AUG')
  end

  def test_identifies_Phenylalanine_codons
    assert_equal 'Phenylalanine', Translation.of_codon('UUU')
    assert_equal 'Phenylalanine', Translation.of_codon('UUC')
  end

  def test_identifies_Leucine_codons
    %w(UUA UUG).each do |codon|
      assert_equal 'Leucine', Translation.of_codon(codon)
    end
  end

  def test_identifies_Serine_codons
    %w(UCU UCC UCA UCG).each do |codon|
      assert_equal 'Serine', Translation.of_codon(codon)
    end
  end

  def test_identifies_Tyrosine_codons
    %w(UAU UAC).each do |codon|
      assert_equal 'Tyrosine', Translation.of_codon(codon)
    end
  end

  def test_identifies_Cysteine_codons
    %w(UGU UGC).each do |codon|
      assert_equal 'Cysteine', Translation.of_codon(codon)
    end
  end
  def test_identifies_Tryptophan_codons
    assert_equal 'Tryptophan', Translation.of_codon('UGG')
  end

  def test_identifies_stop_codons
    %w(UAA UAG UGA).each do |codon|
      assert_equal 'STOP', Translation.of_codon(codon)
    end
  end

  def test_translates_rna_strand_into_correct_protein
    strand = 'AUGUUUUGG'
    expected = %w(Methionine Phenylalanine Tryptophan)
    assert_equal expected, Translation.of_rna(strand)
  end

  def test_stops_translation_if_stop_codon_present
    strand = 'AUGUUUUAA'
    expected = %w(Methionine Phenylalanine)
    assert_equal expected, Translation.of_rna(strand)
  end

  def test_stops_translation_of_longer_strand
    strand = 'UGGUGUUAUUAAUGGUUU'
    expected = %w(Tryptophan Cysteine Tyrosine)
    assert_equal expected, Translation.of_rna(strand)
  end

  def test_invalid_codons
    strand = 'CARROT'
    assert_raises(InvalidCodonError) do
      Translation.of_rna(strand)
    end
  end
end