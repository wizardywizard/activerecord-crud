describe 'Movie' do
  let(:attributes) do
    {
      title: "The Sting",
      release_date: 1973,
      director: "George Roy Hill",
      lead: "Paul Newman",
      in_theaters: false
    }
  end

  it 'inherits from ActiveRecord::Base' do
    expect(Movie.superclass).to eq(ActiveRecord::Base)
  end

  describe '.new' do
    let(:movie) { Movie.new }

    it '#title' do
      expect(movie).to respond_to(:title)
    end

    it '#release_date' do
      expect(movie).to respond_to(:release_date)
    end

    it '#director' do
      expect(movie).to respond_to(:director)
    end

    it '#lead' do
      expect(movie).to respond_to(:lead)
    end

    it '#in_theaters' do
      expect(movie).to respond_to(:in_theaters)
    end

    it 'can be instantiated without any attributes' do
      expect{Movie.new}.not_to raise_error
    end

    it 'can be instantiated with a hash of attributes' do
      expect{Movie.new(attributes)}.not_to raise_error
    end
  end

  describe '#save' do
    it 'can be saved to the database' do
      movie = Movie.new(attributes)
      movie.save
      expect(Movie.find_by(attributes)).to eq(movie)
    end
  end

  describe 'CRUD' do
    describe 'create' do
      it 'can be instantiated and then saved' do
        expect(Movie.any_instance).to receive(:new)
        expect(Movie.any_instance).to receive(:save)

        can_be_instantiated_and_then_saved
      end

      it 'can be created with a hash of attributes' do
        movie = can_be_created_with_a_hash_of_attributes(attributes)
        expect(Movie.find_by(attributes)).to eq(movie)
      end

      it 'can be created in a block' do
        movie = can_be_created_in_a_block do |movie|
          m.title = "Home Alone"
          m.release_date = 1990
        end

        expect(Movie.last).to eq(movie)
        expect(Movie.last.title).to eq("Home Alone")
        expect(Movie.last.release_date).to eq(1990)
      end
    end

    describe 'read' do
      it 'can get the first item in the database' do
        expect(Movie).to receive(:first)
        can_get_the_first_item_in_the_database
      end

      it 'can get the last item in the databse' do
        expect(Movie).to receive(:last)
        can_get_the_last_item_in_the_database
      end

      it 'can count the number of movies' do
        expect(Movie).to receive(:count)
        can_get_size_of_the_database
      end

      it 'can find by id' do
        movie = Movie.find_or_create_by(id: 1, title: "Title")
        expect(Movie).to receive(:find)
        expect(can_find_by_id(1)).to eq(movie)
      end

      it 'can find by multiple attributes' do
        attrs = {
          title: 'Title',
          release_date: 2016,
          lead: 'Me',
          director: 'You'
        }
        movie = Movie.create(attrs)

        expect(can_find_by_multiple_attributes(attrs)).to eq(movie)
      end

      it 'can find using where clause and be sorted' do
        movie1 = Movie.create(title: 'TERRIBLE TITLE')
        movie2 = Movie.create(title: 'TERRIBLE TITLE')

        movies = can_find_using_where_clause_and_be_sorted("title = 'TERRIBLE TITLE'", {id: :desc})

        expect(movies.size).to eq(2)
        expect(movies.first).to eq(movie2)
        expect(movies.last).to eq(movie1)
      end
    end

    describe 'update' do
      it 'can be found, updated, and saved' do
        attrs = {
          title: 'Title',
          release_date: 2016,
          lead: 'Me',
          director: 'You'
        }
        movie = Movie.create(attrs)

        expect {
          can_be_found_updated_and_saved(attrs, 'New Title')
        }.to change(movie, :title).to('New Title')
      end

      it 'can be updated using #update' do
        movie = Movie.create(title: "Wat?")

        expect {
          can_update_using_update_method(movie, "Wat, huh?")
        }.to change(movie, :title).to('Wat, huh?')
      end

      it 'can update all records at once' do
        5.times do
          Movie.create(title: 'my movie')
        end

        can_update_multiple_items_at_once

        expect(Movie.where(title: "my movie").size).to eq(5)
      end
    end

    describe 'destroy' do
      it 'can destroy a single item' do
        movie = Movie.create(title: 'moviemovie')

        expect {
          can_destroy_a_single_item(movie)
        }.to change(Movie, :count).by (-1)

        expect(Movie.find_by(title: "moviemovie")).to be_nil
      end

      it 'can destroy all items at once' do
        can_destroy_all_items_at_once
        expect(Movie.count).to eq(0)
      end
    end
  end
end
