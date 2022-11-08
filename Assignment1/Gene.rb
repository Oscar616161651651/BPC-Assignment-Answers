class Gene  

  attr_accessor :Gene_ID
  attr_accessor :Gene_name
  attr_accessor :mutant_phenotype
  @@all_genes = [] 
  
  def initialize (params = {}) 
    @Gene_ID = params.fetch(:Gene_ID, nil)
    @Gene_name = params.fetch(:Gene_name, nil)
    @mutant_phenotype = params.fetch(:mutant_phenotype, nil)
    @mutant_phenotype = @mutant_phenotype.strip
    @@all_genes << self
  end
  

  #Returns the name of a gene.
  def Gene.find_name(gene_id)
    @@all_genes.each do |gene|
      if gene.Gene_ID == gene_id
        return gene.Gene_name
      end
    end
  end

  def Gene.all_genes
    return @@all_genes
  end
    
end