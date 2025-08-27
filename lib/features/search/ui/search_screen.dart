import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../logic/search_provider.dart';
import '../../../core/network/api_constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(),
      child: Scaffold(
        appBar: AppBar(title: Text('Search Movies')),
        body: Consumer<SearchProvider>(
          builder: (context, provider, _) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(12),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by title...',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                    onChanged: provider.searchMovies,
                  ),
                ),
                if (provider.isLoading)
                  CircularProgressIndicator()
                else if (provider.results.isEmpty)
                  Text('No results found.')
                else
                  Expanded(
                    child: ListView.builder(
                      itemCount: provider.results.length,
                      itemBuilder: (_, index) {
                        final movie = provider.results[index];
                        return ListTile(
                          leading: Image.network(
                            '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(movie.title),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/details',
                              arguments: movie.id,
                            );
                          },
                        );
                      },
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}