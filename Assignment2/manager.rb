require './Function.rb'
require './gene.rb'
require './Networks.rb'
require 'json'

class Manager
  
  attr_accessor :allgenes
  #attr_accessor :new_interactions
  #attr_accessor :new_genes

  def initialize(params = {})
    
    @allgenes = Array.new
    #@new_genes = Hash.new
    #@new_interactions = Array.new
    genefile = params.fetch(:genefile)
    self.load_data(genefile)
    
  end



  def load_data(file)
    
    genefile = File.open(file, 'r')
    genefile.readlines.each do |line|
      line.strip!
      
      gene = Gene.new({:geneid => line,
                       :pathways => find_networks(line),
                       })
      
      paths_info  = gene.iterate_paths
      if paths_info
        #puts "Este: #{patid}"
        paths_info.each do |pathid, pathname|
        
          path = Nets.new({:kegg_id => pathid,
                           :keggname => pathname,
                           :interactors => get_go_terms(get_interactors(pathid)),
                           })
          
          #puts "AQUÍ", path.interactors, "AQUÍ"
          
        end
      end
  
      #puts gene.interaction_networks unless gene.interaction_networks.empty?
      @allgenes.append(gene)
    end
  end
  
    
  def find_networks(id)
      #puts "id: #{id}"
      address = "http://togows.org/entry/kegg-genes/ath:#{id}/pathways.json"
      res = fetch(address);
      if res
        #puts res
        data = JSON.parse(res.body)
        return data
      end
  end
  
  
  def get_interactors(netid)
    #puts netid
    address = "http://togows.org/entry/kegg-pathway/#{netid}/genes.json"
    res = fetch(address);
    if res
      #puts res
      data = JSON.parse(res.body)
      #puts "ESTE", data[0]
      return data[0].keys
    end
  end
    
    
  def get_go_terms(list)
    #  #unless path.interactors == nil && path.interactors[0].empty?
    #  #        puts path.interactors, "@@@@@@@@@@@@@@@@@@@"
    #  #        #puts path.interactors[0].keys, "AAAAAAAAAAAAAAAAAAAA"
    #  #        #path.get_interactors
    #  #      end
    #unless list.empty? 
    #  puts list.class
    #  list.each do |id|
    #    puts id
    #    #address = "http://togows.org/entry/uniprot/#{id}/dr.json"
    #    #res = fetch(address);
    #    #
    #    #data = JSON.parse(res.body)
    #    #puts data
    #  end
    #end
  end
    
    
  def create_output_file
    @allgenes.each do |gene_object|
      puts gene_object
      puts gene_object.iterate_paths
    end
    #output = File.open( "outputfile.txt","w" )
    #output << "This is going to the output file"
    #output.close
  end

  
end