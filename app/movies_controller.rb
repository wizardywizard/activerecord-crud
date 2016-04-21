def can_be_instantiated_and_then_saved
  # Instantiate a movie, assign its attributes, then save it
  movie = Movie.new
  movie.save
end

def can_be_created_with_a_hash_of_attributes(attrs)
  Movie.create(attrs)
end

def can_be_created_in_a_block(&block)
  # pass `&block` to Movie.create
  Movie.create(&block)
end

def can_get_the_first_item_in_the_database
  Movie.first
end

def can_get_the_last_item_in_the_database
  Movie.last
end

def can_count_the_number_of_movies
  Movie.count
end

def can_find_by_id(id)
  Movie.find(id)
end

def can_find_by_multiple_attributes(attrs)
  Movie.find_by(attrs)
end

def can_find_using_where_clause_and_be_sorted(where_clause, sort_order)
  Movie.where(where_clause).order(sort_order)
end

def can_be_found_updated_and_saved(attrs, title)
  # find with `attrs` and change the title to `title`
  movie = Movie.find_by(attrs)
  movie.title = title
  movie.save
end

def can_update_using_update_method(movie, title)
  # change the title of `movie` to `title`

  movie.update(title: title)
end

def can_update_all_records_at_once(title)
  # Change title of all movies to `title`

  Movie.update_all(title: title)
end

def can_destroy_a_single_record(movie)
  movie.destroy
end

def can_destroy_all_records_at_once
  Movie.destroy_all
end
