def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie
  .select(:title, :id)
  .joins(:actors)
  .where(actors: {name: those_actors})
  .group(:id)
  .having('COUNT(actors.id) >= ?', those_actors.length)

end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
  .select('yr/10 * 10 as decade')
  .group('decade')
  .order('AVG(score) DESC')
  .limit(1)
  .first.decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  sub_query =
  Actor
  .select('distinct castings.movie_id')
  .joins(:castings)
  .where(name: name)

  Actor
  .select(:name)
  .joins(:castings)
  .where(castings: {movie_id: sub_query})
  .where.not(name: name)
  .distinct
  .pluck(:name)

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
  .select('COUNT(*)')
  .left_joins(:castings)
  .where(castings: {movie_id: nil})
  .pluck('COUNT(*)')
  .first

end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  match = "%#{whazzername.split(//).join('%')}%"


  Movie
  .joins(:actors)
  .where('lower(actors.name) LIKE lower(?)', match)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor
  .select('actors.id, actors.name, MAX(movies.yr) - MIN(movies.yr) AS career')
  .joins(:movies)
  .group(:id)
  .order('career DESC, actors.name ASC')
  .limit(3)


end
