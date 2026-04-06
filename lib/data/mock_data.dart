import '../models/movie.dart';
import '../models/user.dart';

class MockData {
  static List<Movie> get movies => [
        Movie(
          id: '1',
          title: 'Inception',
          posterUrl: 'https://image.tmdb.org/t/p/w500/9gk7adHYeDvHkCSEqAvQNLV5Uge.jpg',
          genres: ['Sci-Fi', 'Thriller', 'Action'],
          duration: 148,
          rating: 8.8,
          year: 2010,
          description:
              'A thief who steals corporate secrets through the use of dream-sharing technology is given the inverse task of planting an idea into the mind of a C.E.O.',
          moodTags: ['Thrilling', 'Dark', 'Mind-Bending'],
        ),
        Movie(
          id: '2',
          title: 'The Shawshank Redemption',
          posterUrl: 'https://image.tmdb.org/t/p/w500/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg',
          genres: ['Drama'],
          duration: 142,
          rating: 9.3,
          year: 1994,
          description:
              'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
          moodTags: ['Inspiring', 'Emotional'],
        ),
        Movie(
          id: '3',
          title: 'Pulp Fiction',
          posterUrl: 'https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg',
          genres: ['Crime', 'Drama'],
          duration: 154,
          rating: 8.9,
          year: 1994,
          description:
              'The lives of two mob hitmen, a boxer, a gangster and his wife intertwine in four tales of violence and redemption.',
          moodTags: ['Dark', 'Thrilling'],
        ),
        Movie(
          id: '4',
          title: 'The Dark Knight',
          posterUrl: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
          genres: ['Action', 'Crime', 'Drama'],
          duration: 152,
          rating: 9.0,
          year: 2008,
          description:
              'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests.',
          moodTags: ['Action', 'Dark', 'Thrilling'],
        ),
        Movie(
          id: '5',
          title: 'Forrest Gump',
          posterUrl: 'https://image.tmdb.org/t/p/w500/arw2vcBveWOVZr6pxd9XTd1TdQa.jpg',
          genres: ['Drama', 'Romance'],
          duration: 142,
          rating: 8.8,
          year: 1994,
          description:
              'The presidencies of Kennedy and Johnson, the Vietnam War, and other historical events unfold from the perspective of an Alabama man.',
          moodTags: ['Inspiring', 'Emotional', 'Light'],
        ),
        Movie(
          id: '6',
          title: 'The Matrix',
          posterUrl: 'https://image.tmdb.org/t/p/w500/f89U3ADr1oiB1s9GkdPOEpXUk5H.jpg',
          genres: ['Sci-Fi', 'Action'],
          duration: 136,
          rating: 8.7,
          year: 1999,
          description:
              'A computer hacker learns from mysterious rebels about the true nature of his reality and his role in the war against its controllers.',
          moodTags: ['Action', 'Thrilling', 'Mind-Bending'],
        ),
        Movie(
          id: '7',
          title: 'Goodfellas',
          posterUrl: 'https://image.tmdb.org/t/p/w500/aKuFiU82s5ISJpGZp7YkIr3kCUd.jpg',
          genres: ['Crime', 'Drama'],
          duration: 145,
          rating: 8.7,
          year: 1990,
          description:
              'The story of Henry Hill and his life in the mob, covering his relationship with his wife and his partners in crime.',
          moodTags: ['Dark', 'Thrilling'],
        ),
        Movie(
          id: '8',
          title: 'Interstellar',
          posterUrl: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
          genres: ['Sci-Fi', 'Drama', 'Adventure'],
          duration: 169,
          rating: 8.6,
          year: 2014,
          description:
              'A team of explorers travel through a wormhole in space in an attempt to ensure humanity\'s survival.',
          moodTags: ['Emotional', 'Mind-Bending', 'Epic'],
        ),
        Movie(
          id: '9',
          title: 'The Grand Budapest Hotel',
          posterUrl: 'https://image.tmdb.org/t/p/w500/eWdyYQreja6JGCzqHWXpWHDrrPo.jpg',
          genres: ['Comedy', 'Drama'],
          duration: 99,
          rating: 8.1,
          year: 2014,
          description:
              'A writer encounters the owner of an aging high-class hotel, who tells him of his early years serving as a lobby boy.',
          moodTags: ['Funny', 'Light', 'Quirky'],
        ),
        Movie(
          id: '10',
          title: 'Parasite',
          posterUrl: 'https://image.tmdb.org/t/p/w500/7IiTTgloJzvGI1TAYymCfbfl3vT.jpg',
          genres: ['Thriller', 'Drama', 'Comedy'],
          duration: 132,
          rating: 8.6,
          year: 2019,
          description:
              'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.',
          moodTags: ['Thrilling', 'Dark', 'Thought-Provoking'],
        ),
        Movie(
          id: '11',
          title: 'La La Land',
          posterUrl: 'https://image.tmdb.org/t/p/w500/uDO8zWDhfWwoFdKS4fzkUJt0Rf0.jpg',
          genres: ['Romance', 'Musical', 'Drama'],
          duration: 128,
          rating: 8.0,
          year: 2016,
          description:
              'While navigating their careers in Los Angeles, a pianist and an actress fall in love while attempting to reconcile their aspirations.',
          moodTags: ['Romantic', 'Light', 'Inspiring'],
        ),
        Movie(
          id: '12',
          title: 'Get Out',
          posterUrl: 'https://image.tmdb.org/t/p/w500/tFXcEccSQMf3lfhfXKSU9iRBpa3.jpg',
          genres: ['Horror', 'Thriller'],
          duration: 104,
          rating: 7.7,
          year: 2017,
          description:
              'A young African-American visits his white girlfriend\'s parents for the weekend, where his simmering uneasiness about their reception turns into terror.',
          moodTags: ['Thrilling', 'Dark', 'Suspenseful'],
        ),
      ];

  static List<String> get allGenres => [
        'Action',
        'Adventure',
        'Animation',
        'Comedy',
        'Crime',
        'Documentary',
        'Drama',
        'Fantasy',
        'Horror',
        'Mystery',
        'Romance',
        'Sci-Fi',
        'Thriller',
      ];

  static List<String> get moodCategories => [
        'Chill',
        'Action',
        'Funny',
        'Thrilling',
        'Dark',
        'Romantic',
        'Light',
        'Inspiring',
      ];

  static User get currentUser => User(
        id: 'user1',
        name: 'Alex',
        avatarEmoji: '😎',
        avatarColor: '7C3AED',
        preferredGenres: ['Sci-Fi', 'Thriller', 'Action'],
        watchlistIds: ['1', '8'],
        likedMovieIds: ['1', '4', '6'],
        watchedMovieIds: ['2', '3'],
      );

  static List<User> get groupUsers => [
        User(
          id: 'user2',
          name: 'Sarah',
          avatarEmoji: '🎬',
          avatarColor: 'A855F7',
          preferredGenres: ['Drama', 'Romance'],
          watchlistIds: [],
          likedMovieIds: [],
          watchedMovieIds: [],
        ),
        User(
          id: 'user3',
          name: 'Mike',
          avatarEmoji: '🍿',
          avatarColor: '8B5CF6',
          preferredGenres: ['Action', 'Comedy'],
          watchlistIds: [],
          likedMovieIds: [],
          watchedMovieIds: [],
        ),
      ];
}
