require "csv"
require "./Gene_imp.rb"
require "./SeedStock_imp.rb"
require "./HybridCross.rb"

class Database

  attr_accessor :Gene_file
  attr_accessor :Stock_file
  attr_accessor :Cross_file
  attr_accessor :New_file 
  #@@all_genes = [] 
  
  def initialize (params = []) 
    @Gene_file = params[0]
    @Stock_file = params[1]
    @Cross_file = params[2]
    @New_file = params[3]
    check_n_args
    crea_objetos(@Gene_file, @Stock_file, @Cross_file)
    #@@all_genes << self
  end
  
  def check_n_args
    unless @Gene_file && @Stock_file && @Cross_file && @New_file #Corret number of arguments?
      abort "Incorrect number of arguments"
    end
  end

  def show_files
    puts @Gene_file
    puts @Stock_file
    puts @Cross_file
  end

  def parse_tsv(path)
    data = IO.readlines(path)
    data.each_with_index {|val, ind|
      data[ind] = data[ind].split("\t")
      }
    return data
  end

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
    #puts "data :"
    puts data.split(",")
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

  def crea_objetos(gene_path, stock_path, cross_path)
    parsed_gene_file = CSV.read(gene_path, col_sep: "\t", headers: true)
    parsed_stock_file = CSV.read(stock_path, col_sep: "\t", headers: true)
    parsed_cross_file = CSV.read(cross_path, col_sep: "\t", headers: true)

    parsed_gene_file.each do |gene|
      unless gene[0].match(/A[Tt]\d[Gg]\d\d\d\d\d/)
        abort "Incorrect AGI code in Gene_ID (gene_information.tsv)"
      end
      crea_genes(gene)
    end

    parsed_stock_file.each do |stock|
      crea_stocks(stock)
    end

    parsed_cross_file.each do |cross|
      crea_crosses(cross)
    end
  end

  def plant_all(grams)
    SeedStock.all_stocks.each do |stock|
    stock.plant(grams)  
    end
  end

end