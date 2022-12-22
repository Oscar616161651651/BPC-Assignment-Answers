require './Gene.rb' 


class Exon

  attr_accessor :ExonID
  attr_accessor :Seq
  @@all_exons = Hash.new
  
  def initialize (params = {}) 
    @ExonID= params.fetch(:ExonID, nil)
    @Sec = params.fetch(:Seq, nil)
    #@ParentGen = params.fetch(:ParentGen, nil)
    @@all_exons[GeneID] << ExonID
  end
end