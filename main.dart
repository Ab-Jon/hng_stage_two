import 'package:flutter/material.dart';
import 'package:hng_stage2/screens/country_list_screen.dart';
import 'package:hng_stage2/service/api_service.dart';
import 'package:hng_stage2/service/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        Provider(create: (context) => ApiService())
      ],
    child: Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Country App',
          theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: CountryListScreen(),
    );
      },
    )
    );
  }
}
