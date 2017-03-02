
class MovieNode
  attr_reader :title, :year, :actors
  
  def initialize(title,year)
    @title = title 
    @year = year
    @actors = {} #hash of edges string:string
  end 
  
end

class ActorNode
  attr_reader :title, :movies
  
  def initialize(title)
    @title = title
    @movies = {} #Edges with movies
  end 

end

class GraphDB
  
  attr_reader :actors, :movies
  
  def initialize
    @actors = {} #hash of actor_title: actor_node
    @movies = {} #hash of movie_title: movie_node
    @movie_count = 0 
    @actor_count = 0
    @edge_count = 0
  end
  
  def add_movie_node(title,year)
    if !@movies[title]
      movie = MovieNode(title,year)
      @movies[title]= movie
      @movie_count += 1
    end
  end
  
  def add_actor_node(title)
    if !@actors[title]
      actor = ActorNode(title)
      @actors[title]= actor
      @actor_count += 1
    end
  end
  
  def get_actor(title)
    if @actors[title]
      return @actors[title]
    else
      return nil 
    end
  end
  
  def get_movie(title)
    if @movies[title]
      return @movies[title]
    else
      return nil 
    end
  end
  
  def add_edge(movie,actor)
    if @movies[movie] && @actors[actor]
      if @movies[movie].actors[actor] && @actors[actor].movies[movie]
        return "Edge exists"
      else
        @movies[movie].actors[actor] = actor
        @actors[actor].movies[movie] = movie
        @edge_count += 1
        return "Edge was added"
      end
    else
      if @movies[movie]
        return "#{actor} does not exist"
      else
        return "#{movie} does not exist"
      end
    end
  end 
  
  
  
  
end



#This is going to be the join Node for actors and movies

# class YearNode
#   attr_reader :year, :movies
#   def initialize(year,movies,actors)
#     @year = year
#     @movies = []
#   end 
  
#   def add_movie(movie)
#     if !@movies.include? movie
#       @movies.push(movie)
#     end
#   end
  
# end
