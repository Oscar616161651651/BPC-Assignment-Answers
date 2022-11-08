#!/usr/bin/ruby

#Calls required classes
require "./Gene.rb"
require "./SeedStock.rb"
require "./HybridCross.rb"


#Name files
def init_database(args)

    gene_file, stock_file, cross_file, new_file = args
    unless gene_file && stock_file && cross_file && new_file #Corret number of arguments?
      abort "Incorrect number of arguments"
    end

    return gene_file, stock_file, cross_file, new_file
end

#Parses TSV files
def parse_tsv(path)
  data = IO.readlines(path)
  data.each_with_index {|val, ind|
    data[ind] = data[ind].split("\t")
    }
  return data
end

#Functions that create objects with the data from each TSV file.
def crea_genes(data)
  gene_id, gene_name, gene_mut_pheno = data
  
  gene = Gene.new(
   :Gene_ID => gene_id,
   :Gene_name => gene_name,
   :mutant_phenotype => gene_mut_pheno
  )
  return gene
end

def crea_stocks(data)
  seed_stock, mutant_id, last_planted, storage, remaining = data
  
  stock = SeedStock.new(
   :Seed_Stock => seed_stock,
   :Mutant_Gene_ID => mutant_id,
   :Last_Planted => last_planted,
   :Storage => storage,
   :Grams_Remaining =>  remaining
  )
  
  return stock
end

def crea_crosses(data)

  
  parent1, parent2, wild, p1, p2, p1p2 = data
  
  cross = HybridCross.new(
   :Parent1 => parent1,
   :Parent2 => parent2,
   :F2_Wild => wild,
   :F2_P1 => p1,
   :F2_P2 =>  p2,
   :F2_P1P2 =>  p1p2
  )
  
  return cross
end

def crea_objetos(gene_data, stock_data, cross_data)

    #Creates and saves genes + checks ATG
    (gene_data.length - 1).times do |ind| 
      unless gene_data[ind + 1][0].match(/A[Tt]\d[Gg]\d\d\d\d\d/)
        abort "Incorrect AGI code in Gene_ID (gene_information.tsv)"
      end
      crea_genes(gene_data[ind + 1])
    end

    #Creates and saves stocks
    (stock_data.length - 1).times do |ind|
      crea_stocks(stock_data[ind + 1])
    end

    #Creates and saves crosses
    (cross_data.length - 1).times do |ind|
      crea_crosses(cross_data[ind + 1])
    end

end

#Creates output file
def write_outfile(file, stocks_array)
    new = File.new(file, "w")
    new.puts("Seed_Stock	Mutant_Gene_ID	Last_Planted	Storage	Grams_Remaining")
    stocks_array.each do |stock|
      new.puts("#{stock.Seed_Stock}\t#{stock.Mutant_Gene_ID}\t#{stock.Last_Planted}\t#{stock.Storage}\t#{stock.Grams_Remaining.to_i}")
    end
    new.close
end


def check_genetic_linkage(crosses_array)
    crosses_array.each do |that_cross|
    	parent1,parent2,chi_sq = that_cross.genetically_linked
    	if parent1
    	puts "Recording: #{parent1} is genetically linked to #{parent2} with chisquare score #{chi_sq}"
    	end
    end
    puts "\n\nFinal Report:"
    HybridCross.all_linked_genes.each do |cross|
    	puts "#{Gene.find_name(SeedStock.find_gene_ID(cross[0]))} is linked to #{Gene.find_name(SeedStock.find_gene_ID(cross[1]))}"
    	puts "#{Gene.find_name(SeedStock.find_gene_ID(cross[1]))} is linked to #{Gene.find_name(SeedStock.find_gene_ID(cross[0]))}"
    end
end