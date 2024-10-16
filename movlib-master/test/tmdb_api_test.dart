import 'dart:io';
import 'package:mockito/mockito.dart';
import '../lib/model/actor.dart';
import '../lib/model/movie_details.dart';
import '../lib/model/movie.dart';
import '../lib/service/tmdb_api.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {}

void main(){
  group('Tmdb Service', () {
    test('should successfully fetch popular movies and return a list of movies', () async{
      final popMoviesResponse = new File('test/fixtures/pop_movies.json');
      final client = MockClient();
      when(client.get('${TmdbConsts.popularMoviesUrl}1')).thenAnswer((_) async => http.Response(popMoviesResponse.readAsStringSync(), 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      }));
      List<Movie> movies = await TmdbApi(client).fetchPopularMovies(1);

      expect(movies, isA<List<Movie>>());
      expect(movies, hasLength(greaterThan(0)));
    });

    test('should return null when something goes wrong during the fetch movie list process', () async {
      final client = MockClient();
      when(client.get('${TmdbConsts.popularMoviesUrl}0')).thenAnswer((_) async => http.Response('Something went wrong', 500));

      List<Movie> movies = await TmdbApi(client).fetchPopularMovies(0);

      expect(movies, isNull);
    });

    test('should successfully fetch and return the given movie details', () async{
      final movieDetailsResponse = new File('test/fixtures/movie_details.json');
      final client = MockClient();
      when(client.get(TmdbConsts.movieDetailsUrl(0))).thenAnswer((_) async => http.Response(movieDetailsResponse.readAsStringSync(), 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      }));

      MovieDetail movieDetail = await TmdbApi(client).fetchMovieDetails(0);

      expect(movieDetail, isA<MovieDetail>());
      expect(movieDetail, isNotNull);
    });

    test('should return null when something goes wrong during the fetch movie details process', () async {
      final client = MockClient();
      when(client.get(TmdbConsts.movieDetailsUrl(1))).thenAnswer((_) async => http.Response('Something went wrong', 500));

      MovieDetail movieDetail = await TmdbApi(client).fetchMovieDetails(1);

      expect(movieDetail, isNull);
    });

    test('should successfully fetch and return the given movie actors', () async{
      final movieCreditsResponse = new File('test/fixtures/movie_credits.json');
      final client = MockClient();
      when(client.get(TmdbConsts.movieActorsUrl(1))).thenAnswer((_) async => http.Response(movieCreditsResponse.readAsStringSync(), 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      }));
      List<Actor> actors = await TmdbApi(client).fetchActors(1);

      expect(actors, isA<List<Actor>>());
      expect(actors, isNotNull);
    });

    test('should return null when something goes wrong during the fetch movie actors process', () async {
      final client = MockClient();
      when(client.get(TmdbConsts.movieActorsUrl(1))).thenAnswer((_) async => http.Response('Something went wrong', 500));

      List<Actor> actors = await TmdbApi(client).fetchActors(1);

      expect(actors, isNull);
    });

    test('should successfully fetch a movie query and return a list of movies', () async{
      final movieQueryResponse = new File('test/fixtures/movie_query.json');
      final client = MockClient();
      when(client.get(TmdbConsts.movieQueryUrl(1, 'filme'))).thenAnswer((_) async => http.Response(movieQueryResponse.readAsStringSync(), 200, headers: {
        HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
      }));
      List<Movie> movies = await TmdbApi(client).fetchMovieQuery(1, 'filme');

      expect(movies, isA<List<Movie>>());
      expect(movies, hasLength(greaterThan(0)));
    });

    test('should return null when something goes wrong during the fetch movie query process', () async {
      final client = MockClient();
      when(client.get(TmdbConsts.movieQueryUrl(1, 'filme'))).thenAnswer((_) async => http.Response('Something went wrong', 500));

      List<Movie> movies = await TmdbApi(client).fetchMovieQuery(1, 'filme');

      expect(movies, isNull);
    });
  });
}