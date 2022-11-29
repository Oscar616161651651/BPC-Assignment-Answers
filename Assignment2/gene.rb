

class Gene
  

  attr_accessor :geneid
  attr_accessor :pathways
  #attr_accessor :goid
  #attr_accessor :pathname
  #attr_accessor :goterm




  def initialize(params = {})
    @geneid = params.fetch(:geneid, nil)
    @pathways = params.fetch(:pathways, Hash.new)
    #@interactors = find_interactors
    #@keggid = nil
    #@goid = nil
    #@pathname = nil
    #@goterm = nil
  end
    
 

  def iterate_paths
    #puts @interaction_networks
    all_paths = nil   
    unless @pathways[0].empty?
      all_paths = Array.new
      @pathways[0].each do |path_info|
        all_paths.append(path_info)
      end
    if all_paths[0].empty? 
    end
    return all_paths
    end 
  end


 


end