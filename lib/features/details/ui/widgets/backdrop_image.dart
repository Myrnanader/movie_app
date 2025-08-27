import 'package:flutter/material.dart';
import 'package:movie_app/core/network/api_constants.dart';

class BackdropImage extends StatelessWidget {
  final String path;

  const BackdropImage({required this.path});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        '${ApiConstants.imageBaseUrl}$path',
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}