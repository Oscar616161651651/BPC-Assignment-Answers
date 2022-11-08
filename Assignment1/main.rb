require "./Database.rb"

gene_file, stock_file, cross_file, new_file = init_database(ARGV)


#Creates all objects.
crea_objetos(parse_tsv(gene_file), parse_tsv(stock_file), parse_tsv(cross_file))


#"Simulate" planting 7 grams of seeds from each of the records in the seed stock genebank
SeedStock.all_stocks.each do |stock|
  stock.plant(7)
end

#Creates output file.
write_outfile(new_file, SeedStock.all_stocks)

#Checks genetic linkage.
check_genetic_linkage(HybridCross.all_crosses)


