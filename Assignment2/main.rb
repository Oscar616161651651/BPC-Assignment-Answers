require './manager.rb'

gene_file = ARGV[0]
unless gene_file
  abort "Incorrect number of arguments"
end

all_info = Manager.new({:genefile => gene_file})
all_info.create_output_file


