
import 'package:flutter/material.dart';
import 'package:movie_app/core/theme/theme_provider.dart';
import 'package:movie_app/features/home/logic/home_provider.dart';
import 'package:movie_app/features/home/ui/widgets/section_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider()..fetchAllSections(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('MovieVerse'),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => Navigator.pushNamed(context, '/search'),
            ),
            Builder(
              builder: (context) {
                final themeProvider = Provider.of<ThemeProvider>(context);
                return IconButton(
                  icon: Icon(
                    themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                  ),
                  onPressed: () => themeProvider.toggleTheme(!themeProvider.isDarkMode),
                );
              },
            ),
          ],
        ),
        body: Consumer<HomeProvider>(
          builder: (context, provider, _) {
            if (provider.isLoading) return Center(child: CircularProgressIndicator());

            return ListView(
              padding: EdgeInsets.all(12),
              children: [
                SectionWidget(title: 'Trending Movies', movies: provider.trending),
                SectionWidget(title: 'Now Playing', movies: provider.nowPlaying),
                SectionWidget(title: 'Top Rated', movies: provider.topRated),
                SectionWidget(title: 'Upcoming', movies: provider.upcoming),
              ],
            );
          },
        ),
      ),
    );
  }
}