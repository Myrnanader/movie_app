import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/theme_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/splash/ui/splash_screen.dart';
import 'features/home/ui/home_screen.dart';
import 'features/details/ui/movie_details_screen.dart';
import 'features/search/ui/search_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MovieVerseApp(),
    ),
  );
}

class MovieVerseApp extends StatelessWidget {
  const MovieVerseApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieVerse',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.themeMode,
      initialRoute: '/splash',
      routes: {
        '/splash': (_) => SplashScreen(),
        '/': (_) => HomeScreen(),
        '/search': (_) => SearchScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/details') {
          final movieId = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => MovieDetailsScreen(movieId: movieId),
          );
        }
        return null;
      },
    );
  }
}