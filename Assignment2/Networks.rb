

class Nets
  
  attr_accessor :interactors
  attr_accessor :keggid
  attr_accessor :keggname
  #attr_accessor :KEGG_id
  #attr_accessor :KEGG_namwe
  #attr_accessor :all_networks
  
  def initialize(params = {})
    @keggid = params.fetch(:kegg_id, nil)
    @keggname = params.fetch(:keggname, nil)
    @interactors = params.fetch(:interactors, nil)
  end
  
  def get_interactors
    
    @interactors.each do element
      puts element[0]
    end
  
  end
  
  
  
  
end