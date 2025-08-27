import 'package:flutter/material.dart';

class MovieOverview extends StatelessWidget {
  final String overview;

  const MovieOverview({required this.overview});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Overview', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 4),
        Text(overview),
      ],
    );
  }
}