require_relative('terrain_analyser')



terrain = TerrainAnalyser.new

puts("SMALLEST POINT:\n")

terrain.minimum
puts(terrain.min_coordinates)

puts("MEAN HEIGHT:\n")

puts(terrain.mean)

puts("STANDARD DEVIATION:\n")

puts(terrain.sd)

puts("\nSWIMMING POOL\n")

terrain.find_largest_pool



puts("The best pool is #{terrain.largest_pool}")