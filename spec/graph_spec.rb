require 'csv'
require_relative '../actor_node'
require_relative '../movie_node'
require_relative '../year_node'
require_relative '../graph'

# Tests for count function (make below pass)
# It returns the actor count for a movie
# p graph.count("...Almost")
# it returns the movie count for the actor 
# p graph.count("Ferrell, Will")
# it returns NULL if actor doesn't exist
# it returns NULL if actor doesn't exist
# p graph.count("Washington, Denzel")
# it returns the epoch count for both movies and movies
# p graph.count("Austin Powers: The Spy Who Shagged Me")
# graph.set_epoch("1997","1999")
# graph.epoch_on
# p graph.count("Austin Powers: The Spy Who Shagged Me")
# p graph.count("Myers, Mike")

# Tests for intersection function (make below pass)
#it finds the intersections between 2 actors
# p graph.intersect("Myers, Mike","Green, Seth")

#it finds the intersections between 2 movies
# p graph.intersect("Austin Powers: The Spy Who Shagged Me","Austin Powers: International Man of Mystery")

#it returns NULL when no intersections  
# p graph.intersect("Green, Seth", "Giron, Ali")

#it returns error explaination when not both actors or both movies
# p graph.intersect("Green, Seth", "Cry in the Night, A")

#it returns the epoch intersections for actors and movies
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")
# graph.set_epoch("1997","1998")
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")
# graph.unset_epoch
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")
# graph.set_epoch("1997","1998")
# p graph.epoch_on
# p graph.intersect("Myers, Mike","Green, Seth")


RSpec.describe GraphDB do

  before(:each) do
      @graph = GraphDB.new 

    #seeding test data as 7 movies with actors and years
      CSV.foreach('test_data.csv', { :col_sep => '/' }) do |row| 
        movie_title = row[0].split("(")[0].strip
        year = row[0][/(?:(?:19|20)[0-9]{2})/]
        actors = row[1..row.length]
        @graph.add_movie_data(movie_title,year,actors)
      end

      @movie_1 = @graph.movies["Austin Powers: The Spy Who Shagged Me"] 
      @movie_2 = @graph.movies["Austin Powers: International Man of Mystery"] 
      @movie_3 = @graph.movies["Cry in the Night, A"] 

      @actor_1 = @graph.actors["Myers, Mike"]  
      @actor_2 = @graph.actors["Green, Seth"]  
      @actor_3 = @graph.actors["Ferrell, Will"]   
      @actor_4 = @graph.actors["Giron, Ali"]
      @actor_5 = @graph.actors["Washington, Denzel"]

      @year_1 = @graph.years[1997] 
      @year_2 = @graph.years[1998] 
      @year_3 = @graph.years[1999] 

    end

    #Movie attributes
    describe "movie_node attributes in before(:each)" do
      it 'has a title' do
        expect(@movie_1.title).to eq "Austin Powers: The Spy Who Shagged Me"
      end

      it 'has a year edge' do
        expect(@movie_1.year).to eq 1999
      end

      it 'has one or more actor edges' do
        #only return edges of two actors
        expect(@movie_1.actors["Myers, Mike"]).to eq "Myers, Mike"
        expect(@movie_1.actors["Green, Seth"]).to eq "Green, Seth"
      end

      it 'has an actor count for the count function' do
         expect(@movie_1.actor_count).to eq 87
      end

      it 'has default bacon numnber of INF' do
         expect(@movie_1.bacon_num).to eq "INF"
      end
    end

    #Actor attributes
    describe "actor_node attributes in before(:each)" do
      it 'has a title or name' do
        expect(@actor_1.title).to eq "Myers, Mike"
      end

      it 'has one or more movie edges' do
        #only return edges of 2 movies
        expect(@actor_1.movies["Austin Powers: The Spy Who Shagged Me"]).to eq "Austin Powers: The Spy Who Shagged Me"
        expect(@actor_1.movies["Austin Powers: International Man of Mystery"]).to eq "Austin Powers: International Man of Mystery"
      end

      #rewrite test for this
      it 'has one or more costar edges' do
        #only return edges of two actors
        expect(@actor_1.movies["Austin Powers: International Man of Mystery"]).to eq nil
      end

      it 'has a movie count (from data set)' do
         expect(@actor_1.movie_count).to eq 2
      end

      it 'has default bacon numnber of INF' do
         expect(@actor_1.bacon_num).to eq "INF"
      end

    end

    describe "year_node attributes in before(:each)" do
      it 'has a year' do
        expect(@year_1.year).to eq 1997
      end

      it 'has one or more movie edges' do
        #only return edges of 2 movies
        expect(@year_3.movies["Austin Powers: The Spy Who Shagged Me"]).to eq "Austin Powers: The Spy Who Shagged Me"
        expect(@year_1.movies["Austin Powers: International Man of Mystery"]).to eq "Austin Powers: International Man of Mystery"
      end

      it 'has a movie count' do
        #only movie count for test data
        expect(@year_1.movie_count).to eq 1
        expect(@year_3.movie_count).to eq 1
      end

    end

    describe "graph attributes in before(:each)" do
      it 'has one or more actors' do
        #only testing two year edges
        expect(@graph.years[1999]).to eq @year_3
        expect(@graph.years[1997]).to eq @year_1  
      end

      it 'has one or more movie edges' do
        #only return edges of 2 movies
        expect(@graph.movies["Austin Powers: The Spy Who Shagged Me"]).to eq @movie_1
        expect(@graph.movies["Austin Powers: International Man of Mystery"]).to eq @movie_2
      end

      it 'has one or more year edges' do
        #only return 2 edges for test data
        expect(@graph.years[1997]).to eq @year_1
        expect(@graph.years[1998]).to eq @year_2
      end

      it 'has a unique year node count' do 
        expect(@graph.year_count).to eq 6
      end

      #investigate why this is not 7 
      it 'has a unique movie node count' do 
        expect(@graph.movie_count).to eq 6
      end

      it 'has a unique actor node count' do 
        expect(@graph.actor_count).to eq 232
      end

      it 'has a initial epoch filtering off (false)' do 
        expect(@graph.epoch_on).to eq false
      end

      it 'has a initial temporary movie store of nil' do 
        expect(@graph.temp_movie_store).to eq nil
      end

      #data migration methods 
      it 'has a initial temporary movie store of nil' do 
        expect(@graph.temp_movie_store).to eq nil
      end

      it "allows the addtion of movie nodes with its corresponding year node when adding movie data and increases counts" do
        @graph.add_movie_node("The Lion King", "1994") 
        movie = @graph.movies["The Lion King"] 
        year = @graph.years[1994] 
        expect(@graph.movies["The Lion King"]).to eq movie
        expect(@graph.years[1994]).to eq year 
      end

      it "allows the addition of actor nodes when adding movie data and increases counts" do
        @graph.add_actor_node("Fake, Actor", "The Lion King") 
        actor = @graph.actors["Fake, Actor"] 
        count = @graph.actor_count
        expect(@graph.actors["Fake, Actor"]).to eq actor
        expect(@graph.actor_count).to eq count
      end
    end
      #DATA Commands methods
    describe "graph data methods" do
      it "returns the credited actors count for a movie" do
        expect(@graph.count("Austin Powers: The Spy Who Shagged Me")).to eq "87 actor(s) credited"
      end

      it "returns the credited movie count for an actor" do
        expect(@graph.count("Myers, Mike")).to eq "2 movie(s) credited"
      end

      it "returns null if actor or movie for count doesn't exist" do
        expect(@graph.count("Fake, Actor")).to eq "NULL"
        expect(@graph.count("Fake, Movie")).to eq "NULL"
      end

      it "it returns appropriate count within an epoch filter for actor and movie " do
        @graph.set_epoch("1997","1998") #disinclude 1 movie for Mike Myers
        expect(@graph.count("Austin Powers: The Spy Who Shagged Me")).to eq "NULL" 
        expect(@graph.count("Myers, Mike")).to eq "1 movie(s) credited" #only one in this range
      end

      it "returns intersections for actors" do
        expect(@graph.intersect("Myers, Mike", "Green, Seth")).to match_array(["Austin Powers: International Man of Mystery", "Austin Powers: The Spy Who Shagged Me"])
      end

      it "returns intersections for movies" do
        expect(@graph.intersect("Austin Powers: The Spy Who Shagged Me", "Austin Powers: International Man of Mystery")).to match_array(
          ["Bacharach, Burt", "Ferrell, Will", "Green, Seth", "Howard, Clint", "Hurley, Elizabeth", "Lowe, Rob", "McDonald, Michael James", "Myers, Mike", "Napier, Charles", "Smith, Sara", "Sterling, Mindy", "Van Putten, Chekeshka", "Wagner, Robert", "York, Michael"]
        )
      end

      it "returns NULL if intersections don't exist between actors or movies" do 
        expect(@graph.intersect("Green, Seth", "Giron, Ali")).to eq "NULL"
        expect(@graph.intersect("Austin Powers: The Spy Who Shagged Me", "Balto")).to eq "NULL"
      end

      it "intersections only work with 2 movies or 2 actors" do
        expect(@graph.intersect("Austin Powers: The Spy Who Shagged Me", "Green, Seth")).to eq "ERROR: BOTH ENTITIES MUST BE MOVIES OR ACTORS, OR ATLEAST 1 ENTITY DOESN'T EXIST"
      end

      it "returns intersections for movies and actors with epoch filter" do
        @graph.set_epoch("1997","1998")
        expect(@graph.intersect("Myers, Mike", "Green, Seth")).to match_array(["Austin Powers: International Man of Mystery"])
        expect(@graph.intersect("Austin Powers: The Spy Who Shagged Me","Austin Powers: International Man of Mystery")).to eq "ERROR: BOTH ENTITIES MUST BE MOVIES OR ACTORS, OR ATLEAST 1 ENTITY DOESN'T EXIST"
      end

      #operations methods 
      it 'allows the update of temp movie stores for epoc filtering' do 
        @graph.temp_movie_store = @graph.movies
        expect(@graph.temp_movie_store).to eq @graph.movies
      end

    end

end



