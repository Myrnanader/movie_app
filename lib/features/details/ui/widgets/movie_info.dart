import 'package:flutter/material.dart';

class MovieInfo extends StatelessWidget {
  final String title;
  final double rating;
  final String releaseDate;

  const MovieInfo({required this.title, required this.rating, required this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineSmall),
        SizedBox(height: 8),
        Text('⭐ $rating   📅 $releaseDate'),
      ],
    );
  }
}