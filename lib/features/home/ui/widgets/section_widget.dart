import 'package:flutter/material.dart';
import 'package:movie_app/features/home/models/movie_model.dart';
import 'package:movie_app/features/home/ui/widgets/movie_card.dart';

class SectionWidget extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const SectionWidget({required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (_, index) => MovieCard(movie: movies[index]),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}