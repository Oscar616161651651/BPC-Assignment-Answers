require './MarksFunction.rb'
require 'bio'

puts 13573070 - 13571813

s = {}
mets = s.methods
mets.sort!
#puts mets

# # res = fetch(url: 'http://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ensemblgenomesgene&format=fasta&id=AT3G54340');
res = fetch(url: 'http://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ensemblgenomesgene&id=AT3G54340&format=embl');
# https://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ena_sequence&id=J00231,K00650,D87894,AJ242600&format=fasta
  if res
    body = res.body

    
    embl_object = Bio::EMBL.new(body)
    # Iterate over all features and print
    embl_object.features.each do |feature|
      next unless feature.feature == 'exon'
      #puts feature.feature + "\s\s\s\s" + feature.position
      puts feature.position
      #puts feature.feature
      feature.each do |qualifier|
      	next unless qualifier.qualifier == 'note'
        #puts "- " + qualifier.qualifier + ": " + qualifier.value
        puts qualifier.value.gsub('exon_id=', '')
      end
    end
    #puts embl_object.seq()
    embl_object.features.each do |feature|
      #puts feature.methods.sort
      position = feature.position
      #puts "\nPOSITION = #{position}"+"   ASSOCIATIONS = #{feature.assoc}"
      qual = feature.assoc
      #puts "Associations = #{qual}"
      #next unless qual['exon']
    end




    # body.each_line do |line|
    #   puts line
    #   if line =~ /FT   exon/
    #   	puts "ENCONTRÉ UN EXÓN"
    #   end
    # end
    # lines = body.split("\n")
    # puts lines.class
    # lines.each_with_index do |val, ind|
    # 	#puts "Línea número #{ind} es: #{val}"
    # 	if ind > 600
    # 		puts val
    # 	end
    # end

    # if body =~ /locus_tag="([^"]+)"/ 
    #   gene_name = $1
    #   puts "the name of the gene is #{gene_name}"
    #     #puts body.class
    #   #body.each do |test|
    #   	#puts test
    #     #end
    # end
    # m = /FT   exon            complement(.+\.\..+)/.match(body)
    # puts m
  end

#res = fetch(url: 'http://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ensemblgenomesgene&format=embl&id=At3g54340');
#puts res.body
# res2 = fetch(url: 'http://www.ebi.ac.uk/Tools/dbfetch/dbfetch?db=ensemblgenomesgene&id=AT3G54340&format=fasta');
# if res2
# 	puts res2.body
# end


# CC   All feature locations are relative to the first (5') base of the sequence
# CC   in this file.  The sequence presented is always the forward strand of the
# CC   assembly. Features that lie outside of the sequence contained in this file
# CC   have clonal location coordinates in the format: .:..