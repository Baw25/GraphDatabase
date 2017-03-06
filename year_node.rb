#Relationships between the graph nodes: 

#Movie node has many actor nodes 
#Movie node has only one year node 
#Actor node has many movie nodes
#Actor node will have many year nodes through the movie nodes
#Year node has many movie nodes 
#Year node has many actor nodes through movies


class YearNode
  attr_accessor :movies, :movie_count
  attr_reader :year

  def initialize(year)
    @year = year
    @movies = {} #edges directed at movie nodes
    @movie_count = 0
  end 
  
end

