import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/features/details/logic/details_provider.dart';
import 'package:movie_app/features/details/ui/widgets/backdrop_image.dart';
import 'package:movie_app/features/details/ui/widgets/cast_list.dart';
import 'package:movie_app/features/details/ui/widgets/movie_info.dart';
import 'package:movie_app/features/details/ui/widgets/movie_meta.dart';
import 'package:movie_app/features/details/ui/widgets/movie_overview.dart';
import 'package:movie_app/features/details/ui/widgets/trailer_player.dart';

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
            final trailers = provider.trailers;

            final isLoading =
                provider.isLoadingDetails || provider.isLoadingCast || provider.isLoadingVideos;

            if (isLoading) {
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
                  BackdropImage(path: movie.backdropPath),
                  SizedBox(height: 16),
                  MovieInfo(
                    title: movie.title,
                    rating: movie.voteAverage,
                    releaseDate: movie.releaseDate,
                  ),
                  SizedBox(height: 16),
                  MovieOverview(overview: movie.overview),
                  SizedBox(height: 16),
                  MovieMeta(genres: movie.genres, runtime: movie.runtime),
                  SizedBox(height: 24),
                   // Cast Section
                  CastList(cast: cast),

                  //Trailer Section
                  if (trailers.isNotEmpty) ...[
                    Text('Trailer', style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(height: 8),
                    TrailerPlayer(youtubeKey: trailers.first.key),
                    SizedBox(height: 24),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}