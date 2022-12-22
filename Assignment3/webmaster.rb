#!/usr/bin/ruby

#Calls required classes
require './MarksFunction.rb'
require './Gene.rb'
require 'bio'



class Webmaster
  attr_accessor :gene_list
  # attr_accessor :Gene_name
  # attr_accessor :mutant_phenotype
  # @@all_genes = Array.new
  
  def initialize (arg)
    @gene_list = Array.new
    gene_file = arg
    process_gene_file(gene_file)

    return gene_file
  end  

  # Parse Gene File and creates Gene Objects.
  def process_gene_file(file)
    data = IO.readlines(file)
    data.each do |gene|
      create_gene(gene)
    end
  end

  def create_gene(gene_id)
    seq, exon_info = search_web_data(gene_id)
    gene = Gene.new(
      :GeneID => gene_id,
      :Seq => seq,
      :ExonInfo => exon_info
      )
    #puts gene.FastaSeq
  end

  def search_web_data(gene_id)

    res = fetch(url: "http://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ensemblgenomesgene&id=#{gene_id}&format=embl");

    if res
    # Creates a Bio object to manage with EMBL format.
    embl_object = Bio::EMBL.new(res.body)
    # puts gene_id
    # puts "AT4g27030".length
    # puts gene_id.strip.eql?"AT4g27030"
    # if gene_id.strip.eql?"AT4g27030"
    #   puts "EEEEESSSSSS    IIIIIGGGGUUUUUUAAAAALLLLLL"
    #   File.open("./example.txt", "w") { |file|
    #     res.body.each_char do |caracter|
    #       file.write(caracter)
    #     end
    #    }
    # end
    gen_seq = embl_object.seq

    # Hash containing exon info: {ExonID : ExonPosition}
    exon_info = {}

    # Iterate over all features and print
    embl_object.features.each do |feature|

      next unless feature.feature == 'exon'
      puts feature.position

      exon_position = feature.position
      feature.each do |qualifier|
        puts "HHHHHOOOOOOOOLLLLLLAAAAAAA #{qualifier.qualifier}"
        next unless qualifier.qualifier == 'note'

        puts qualifier.value.gsub('exon_id=', '')
        exon_id = qualifier.value.gsub('exon_id=', '')

        if defined?(exon_id)
          exon_info[exon_id] = exon_position
          puts "AQUÍ ESTARÍA #{exon_info}"
        else
          exon_info = {}
          puts "AQUÍ ESTARÍA #{exon_info}"
          next
        end


      end


    end

    puts exon_info
    return [gen_seq, exon_info]
  end

  end

    
end

