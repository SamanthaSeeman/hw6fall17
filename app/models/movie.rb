class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
class Movie::InvalidKeyError < StandardError ; end
Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
  
def self.find_in_tmdb(string)
  array_hashes = []
  
   begin
#      Tmdb::Movie.find(string)
array_search = Tmdb::Movie.find(string)

    rescue Tmdb::InvalidApiKeyError
        raise Movie::InvalidKeyError, 'Invalid API key'
        
    end
      
    if matching_movies.nil? or matching_movies.empty?
       return []
    end
    
    array_search.each do |movie|
        rating_tmdb = Tmdb::Movie.releases(movie.id)["countries"]
         rating = ""
           rating_tmdb.each do |n|
             if n["iso_3166_1"].upcase == 'US'
               rating = n['certification']
             end
           end
       hash = {}
       hash[:tmdb_id] = movie.id
       hash[:title] = movie.title
       hash[:release_date] = movie.release_date
       hash[:rating] = rating
       array_hashes.push(hash)
     end
    return array_hashes
    
  end

end
