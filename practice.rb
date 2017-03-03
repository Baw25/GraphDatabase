
# Movie Node class
class MovieNode
  attr_reader :title, :year, :actors, :actor_count, :bacon_num
  
  def initialize(title,year)
    @title = title 
    @year = year.to_i
    @actors = {} #hash of edges string:string
    @actor_count = 0
    @bacon_num = nil
  end 
  
end

#Actor node class
class ActorNode
  attr_reader :title, :movies, :movie_count, :bacon_num
  
  def initialize(title)
    @title = title
    @movies = {} #Edges with movies
    @movie_count = 0
    @bacon_num = nil
  end 

end

class YearNode
  attr_reader :year
  attr_accessor :movies, :movie_count

  def initialize(year)
    @year = year
    @movies = {}
    @movie_count = 0
  end 
  
end

#Graph class 

class GraphDB
  attr_reader :actors, :movies, :years, :epoch_on
  
  def initialize
    @actors = {} #hash of actor_title: actor_node
    @movies = {} #hash of movie_title: movie_node
    @years = {} #hash of year: year_node 
    @temp_movie_store = nil 
    @epoch_on = false
    @movie_count = 0 
    @actor_count = 0
    @year_count = 0
    @edge_count = 0
  end
  
  def add_movie_node(title,year)
    if !@movies[title]
      movie_node = MovieNode.new(title,year.to_i)
      @movies[title]= movie_node
      @movie_count += 1
      add_year_node(year,title)
    end
  end
  
  def add_actor_node(title)
    if !@actors[title]
      actor_node = ActorNode.new(title)
      @actors[title]= actor_node
      @actor_count += 1
    end
  end

  def add_year_node(year,movie_title)
    if !@years[year.to_i]
      year_node = YearNode.new(year.to_i)
      year_node.movies[movie_title] = movie_title
      year_node.movie_count += 1
      @years[year.to_i]= year_node
      @year_count += 1
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
  
  def add_edges(movie,actor,year)
    year = year.to_i
    if @movies[movie] && @actors[actor] && @years[year]
      if @movies[movie].actors[actor] && @actors[actor].movies[movie] && @years[year].movies[movie]
        return "Edges exists"
      else
        @movies[movie].actors[actor] = actor
        @movies[movie].actor_count += 1
        @actors[actor].movies[movie] = movie
        @actors[actor].movie_count += 
        @years[year].movies[movie] = movie
        @years[year].movies[movie] += 1
        @edge_count += 2
        return "Edges were added"
      end
    else
      if @movies[movie]
        return "#{actor} does not exist"
      elsif @actors[actor]
        return "#{movie} does not exist"
      else
        return "#{year} does not exist"
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
      puts find_intersections(ent_a,ent_b,"movies")
    elsif @actors[ent_a] && @actors[ent_b]
      puts find_intersections(ent_a,ent_b,"actors")
    elsif @actors[ent_a] || @actors[ent_b] && @movies[ent_a] || @movies[ent_b]
      return "ERROR: BOTH ENTITIES MUST BE MOVIES OR ACTORS"
    else
      return "ERROR: ONE ENTITY DOESN'T EXIST"
    end
  end 

  #return the bacon # for actor or movie
  #if actor and Kevin Bacon --> 0
  #if actor shared movie with Kevin Bacon --> 1
  #if other actor --> 1 + lowest Bacon # with all 
  #actors they share a movie with 
  #if actor and no chain back to Bacon, INF
  #if movie, return lowest bacon # of all actors or 
  #INF if all actors in the film have INF

  # def get_bacon_num(entity)
  #   if @movies[entity]
  #     return calculate_bacon(entity,"movies")
  #   elsif @actors[entity]
  #     return calculate_bacon(entity,"actors")
  #   else
  #     return "ERROR: INVALID INPUT"
  #   end
  # end 


  #filter for movie years including start and end years
  #should I filter by yearnode or by year attribute in movie 
  def set_epoch(start_yr,end_yr)
  
    if start_yr > end_yr
      return "ERROR: START YEAR MUST BE GREATER"
    elsif start_yr == "NULL" 
      beginning = @years.keys.min 
      ending = end_yr.to_i
    elsif end_yr == "NULL"
      beginning = start_yr.to_i
      ending = @years.keys.max
    end

    filtered_movies = {}
    temp = @movies
    @temp_movie_store = temp
    (beginning..ending).each do |year| 
      filtered_movies.merge(@years[year].movies) if @years[year]
    end
    @movies = filtered_movies
    @epoch_on = true
  end 


  def unset_epoch
    total_movies = @temp_movie_store
    @movies = total_movies
    @temp_movie_store = nil
    @epoch_on = false
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

  # def calculate_bacon(entity,entity_type)
  #   if entity_type == "movies"

  #   else

  #   end
  # end


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
