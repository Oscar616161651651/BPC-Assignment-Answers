require "./Database_imp.rb"

database = Database.new(ARGV)
database.show_files

database.plant_all(7)


