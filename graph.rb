#Relationships between the graph nodes: 

#Movie node has many actor nodes 
#Movie node has only one year node 
#Actor node has many movie nodes
#Actor node will have many year nodes through the movie nodes
#Year node has many movie nodes 
#Year node has many actor nodes through movies

require_relative "./movie_node"
require_relative "./actor_node"
require_relative "./year_node"

#Graph class 

class GraphDB
  attr_accessor :actors, :movies, :years, :epoch_on, :temp_movie_store
  attr_reader :movie_count, :actor_count, :year_count
  def initialize
    @actors = {} #collection of actor nodes
    @movies = {} #collection of movie nodes
    @years = {} #collection of year nodes
    @temp_movie_store = nil #temp store movie store for epoch fx
    @epoch_on = false #state of epoch function 
    @movie_count = 0 
    @actor_count = 0
    @year_count = 0
    # @edge_count = 0
  end

  #call this method as you read the data line by line 
  #takes an array of actors

  def add_movie_data(movie_title,year,actors)
    add_movie_node(movie_title,year)
    actors.each do |actor| 
      add_actor_node(actor,movie_title)
      @actors[actor].movies[movie_title] = movie_title
      @movies[movie_title].actors[actor] = actor
      @movies[movie_title].actor_count += 1
    end
  end

  def add_movie_node(title,year)
    if !@movies[title]
      movie_node = MovieNode.new(title,year.to_i)
      @movies[title]= movie_node
      @movie_count += 1
      add_year_node(year,title)
    end
  end
  
  def add_actor_node(title,movie_title)
    if !@actors[title]
      actor_node = ActorNode.new(title)
      actor_node.movies[movie_title] = movie_title
      actor_node.movie_count += 1
      @actors[title]= actor_node
      @actor_count += 1
    else
      @actors[title].movies[movie_title] = movie_title
      @actors[title].movie_count += 1
    end
  end

  def add_year_node(year,movie_title)
    if !@years[year.to_i]
      year_node = YearNode.new(year.to_i)
      year_node.movies[movie_title] = movie_title
      year_node.movie_count += 1
      @years[year.to_i]= year_node
      @year_count += 1
    else
      @years[year.to_i].movies[movie_title] = movie_title
      @year[year.to_i].movie_count += 1
    end
  end
 
  #Count function 
  #return # actors credited on movie 
  #return # movies credited to actor

  def count(ent_a)
    if @actors[ent_a]
      if !epoch_on
        return "#{@actors[ent_a].movie_count} movie(s) credited"
      else
        return "#{@actors[ent_a].movies.keys.count { |x| @movies.keys.include?(x) } } movie(s) credited"
      end
    elsif @movies[ent_a]
      if !epoch_on
        return "#{@movies[ent_a].actor_count} actor(s) credited"
      else 
        return "#{@temp_movie_store[ent_a].actor_count} actor(s) credited"        
      end
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
      return "ERROR: BOTH ENTITIES MUST BE MOVIES OR ACTORS, OR ATLEAST 1 ENTITY DOESN'T EXIST"
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

  # def bacon(entity)
  #   if @movies[entity]
  #     # return calculate_bacon(entity,"movies")
  #     return @movies[entity].bacon_num
  #   elsif @actors[entity]
  #     # return calculate_bacon(entity,"actors")
  #     return @actors[entity].bacon_num
  #   else
  #     return "ERROR: INVALID INPUT"
  #   end
  # end 


  #filter for movie years including start and end years
  #should I filter by yearnode or by year attribute in movie 

  def set_epoch(start_yr,end_yr)
  
    if start_yr.to_i > end_yr.to_i
      return "ERROR: START YEAR MUST BE GREATER"
    elsif start_yr == "NULL" 
      beginning = @years.keys.min 
      ending = end_yr.to_i
    elsif end_yr == "NULL"
      beginning = start_yr.to_i
      ending = @years.keys.max
    else
      beginning = start_yr.to_i
      ending = end_yr.to_i
    end

    filtered_movies = {}
    temp = @movies
    self.temp_movie_store = temp
    (beginning..ending).each do |year| 
      filtered_movies.merge!(@years[year].movies) if @years[year]
    end
    self.movies = filtered_movies
    self.epoch_on = true
  end 


  def unset_epoch
    total_movies = @temp_movie_store
    self.movies = total_movies
    self.temp_movie_store = nil
    self.epoch_on = false
  end 

  private

  #Linear operation dependent on the # actors for one of the movies
  def find_intersections(ent_a,ent_b,type)
    intersections = []
    if type == "movies" && !@epoch_on
      @movies[ent_a].actors.each do |key,value|
        intersections.push(key) if @movies[ent_b].actors[key]
      end
    elsif type == "movies" && @epoch_on
      @temp_movie_store[ent_a].actors.each do |key,value|
        intersections.push(key) if @temp_movie_store[ent_b].actors[key]
      end
    else
      @actors[ent_a].movies.each do |key,value|
        intersections.push(key) if @actors[ent_b].movies[key] && @movies[key]
      end
    end
    puts intersections.length > 0 ? intersections : "NULL" 
    return intersections.length > 0 ? intersections : "NULL" 
  end


end

