import 'package:flutter/material.dart';

class MovieMeta extends StatelessWidget {
  final List<String> genres;
  final int runtime;

  const MovieMeta({required this.genres, required this.runtime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Genres: ${genres.join(', ')}'),
        Text('Runtime: $runtime mins'),
      ],
    );
  }
}