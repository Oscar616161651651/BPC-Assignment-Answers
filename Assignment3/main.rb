#!/usr/bin/env ruby

require './webmaster.rb'


gene_file = ARGV[0]
unless gene_file
  abort "Incorrect number of arguments"
end

db = Webmaster.new(gene_file)

# Gene.all_gene_seqs

# test = Gene.all_genes
# test.each do |gene|
# 	puts gene.FastaSeq
# end

Gene.all_genes