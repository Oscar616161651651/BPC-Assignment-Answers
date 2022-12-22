require './Exon.rb'

class Gene  

  attr_accessor :GeneID
  attr_accessor :GeneSeq
  attr_accessor :ExonInfo
  @@all_genes = Array.new
  
  def initialize (params = {}) 
    @GeneID = params.fetch(:GeneID, nil)
    @GeneSeq = params.fetch(:GeneSeq, nil)
    @ExonInfo = params.fetch(:ExonInfo, nil)
  #  @mutant_phenotype = params.fetch(:mutant_phenotype, nil)
  #  @mutant_phenotype = @mutant_phenotype.strip
    @@all_genes << self
    puts "Aquí estaría: #{@ExonInfo}"
    create_exons(@ExonInfo)
    #puts @GeneID
  end
  
  def create_exons(exon_hash)
    exon_hash.each_pair do |exon_id, position|
      puts "Comprobando create_exons function in Gene script -- #{exon_id} -  #{position}"
      exon_seq = search_exon_seq(self.GeneSeq, position)

      exon = Gene.new(
        :ExonID => exon_id,
        :Seq => exon_seq
        )
      puts exon
    end
  end

  def search_exon_seq(gene_sec, exon_position)
    puts gene_sec
    puts exon_position
    return "Por terminar"
  end

  def Gene.all_gene_seqs
    @@all_genes.each do |gene|
      puts gene
      puts gene.FastaSeq
    end
  end

  def Gene.all_genes
    return @@all_genes
  end
    
end


  # Returns the fasta sequence of a gene.
  #def Gene.get_seq()

  # #Returns the name of a gene.
  # def Gene.find_name(gene_id)
  #   @@all_genes.each do |gene|
  #     if gene.Gene_ID == gene_id
  #       return gene.Gene_name
  #     end
  #   end
  # end


