
# Movie Node class
class MovieNode
  attr_reader :title, :year, :actors, :actor_count
  
  def initialize(title,year)
    @title = title 
    @year = year
    @actors = {} #hash of edges string:string
    @actor_count = 0
  end 
  
end

#Actor node class
class ActorNode
  attr_reader :title, :movies, :movie_count
  
  def initialize(title)
    @title = title
    @movies = {} #Edges with movies
    @movie_count = 0
  end 

end

#Graph class 

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
  end#W
  
  def add_edge(movie,actor)
    if @movies[movie] && @actors[actor]
      if @movies[movie].actors[actor] && @actors[actor].movies[movie]
        return "Edge exists"
      else
        @movies[movie].actors[actor] = actor
        @movies[movie].actor_count += 1
        @actors[actor].movies[movie] = movie
        @actors[actor].movie_count += 1
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
  
  #Count function 
  #return # actors credited on movie 
  #return # movies credited to actor

  def count(ent_a)
    if @actors[ent_a]
      return @actors[ent_a].movie_count
    elsif @movies[ent_a]
      return @movies[ent_a].actor_count
    else
      return "NULL"
    end 
  end

  #intersect function 
  #2 movies --> list of all actors in both movies
  #2 actors --> list of all movies with both actors
  #return null if no intersection
  #ERROR, must enter both movies or both actors

  def intersect(ent_a,ent_b)
    if @movies[ent_a] && @movies[ent_b]
      return find_intersections(ent_a,ent_b,"movies")
    elsif @actors[ent_a] && @actors[ent_b]
      return find_intersections(ent_a,ent_b,"actors")
    elsif @actors[ent_a] || @actors[ent_b] && @movies[ent_a] || @movies[ent_b]
      return "ERROR: BOTH ENTITIES MUST BE MOVIES OR ACTORS"
    else
      return "ERROR: ONE ENTITY DOESN'T EXIST"
    end
  end 

  def calculate_bacon
  end 

  def set_epoch
  end 

  def unset_epoch
  end 

  private

  #Linear operation dependent on the # actors for one of the movies
  def find_intersections(ent_a,ent_b,type)
    intersections = []
    if type == "movies"
      @movies[ent_a].actors.each do |key,value|
        intersections.push(key) if @movies[ent_b].actors[key]
      end
    else
      @actors[ent_a].movies.each do |key,value|
        intersections.push(key) if @actors[ent_b].movies[key]
      end
    end
    return intersections.length > 0 ? intersections : nil 
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
