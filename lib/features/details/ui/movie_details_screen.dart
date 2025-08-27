/*import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/details_provider.dart';
import '../../../core/network/api_constants.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailsProvider()..fetchAllMovieData(movieId),
      child: Scaffold(
        appBar: AppBar(title: Text('Movie Details')),
        body: Consumer<DetailsProvider>(
          builder: (context, provider, _) {
            final movie = provider.movie;
            final cast = provider.cast;

            if (provider.isLoadingDetails || provider.isLoadingCast) {
              return Center(child: CircularProgressIndicator());
            }

            if (movie == null) {
              return Center(child: Text('No details found.'));
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Backdrop
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      '${ApiConstants.imageBaseUrl}${movie.backdropPath}',
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Title & Rating
                  Text(movie.title, style: Theme.of(context).textTheme.headlineSmall),
                  SizedBox(height: 8),
                  Text('⭐ ${movie.voteAverage}   📅 ${movie.releaseDate}'),

                  SizedBox(height: 16),

                  // Overview
                  Text('Overview', style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 4),
                  Text(movie.overview),

                  SizedBox(height: 16),

                  // Genres & Runtime
                  Text('Genres: ${movie.genres.join(', ')}'),
                  Text('Runtime: ${movie.runtime} mins'),

                  SizedBox(height: 24),

                  // Cast Section
                  Text('Cast', style: Theme.of(context).textTheme.titleMedium),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 150,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: cast.length,
                      separatorBuilder: (_, __) => SizedBox(width: 12),
                      itemBuilder: (context, index) {
                        final actor = cast[index];
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                '${ApiConstants.imageBaseUrl}${actor.profilePath}',
                                height: 100,
                                width: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 100,
                                  width: 80,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.person),
                                ),
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              actor.name,
                              style: TextStyle(fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
*/
import 'package:flutter/material.dart';
import 'package:movie_app/features/details/logic/details_provider.dart';
import 'package:movie_app/features/details/ui/widgets/backdrop_image.dart';
import 'package:movie_app/features/details/ui/widgets/cast_list.dart';
import 'package:movie_app/features/details/ui/widgets/movie_info.dart';
import 'package:movie_app/features/details/ui/widgets/movie_meta.dart';
import 'package:movie_app/features/details/ui/widgets/movie_overview.dart';
import 'package:provider/provider.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  const MovieDetailsScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DetailsProvider()..fetchAllMovieData(movieId),
      child: Scaffold(
        appBar: AppBar(title: Text('Movie Details')),
        body: Consumer<DetailsProvider>(
          builder: (context, provider, _) {
            if (provider.isLoadingDetails || provider.isLoadingCast) {
              return Center(child: CircularProgressIndicator());
            }

            final movie = provider.movie;
            final cast = provider.cast;

            if (movie == null) {
              return Center(child: Text('No details found.'));
            }

            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackdropImage(path: movie.backdropPath),
                  SizedBox(height: 16),
                  MovieInfo(title: movie.title, rating: movie.voteAverage, releaseDate: movie.releaseDate),
                  SizedBox(height: 16),
                  MovieOverview(overview: movie.overview),
                  SizedBox(height: 16),
                  MovieMeta(genres: movie.genres, runtime: movie.runtime),
                  SizedBox(height: 24),
                  CastList(cast: cast),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}