import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../service/theme_provider.dart';
import 'country_detail_screen.dart';
import '../models/country.dart';
import '../service/api_service.dart';

class CountryListScreen extends StatefulWidget {
  const CountryListScreen({super.key});

  @override
  State<CountryListScreen> createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {

  late Future<List<Country>> _countries; //list to store the countries
  List<Country> _filteredCountries = []; // list to store the filtered countries
  String? selectedContinent;
  String? selectedTimeZone;
  List<Country> _allCountries = [];
  final TextEditingController _searchController =  TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCountries();
    _searchController.addListener(_filterCountries);
    _countries = Provider.of<ApiService>(context, listen: false).fetchCountries();

  }

  // Method to fetch the countries from the API
  void _fetchCountries() async {
    final apiService = Provider.of<ApiService>(context, listen: false);
    _countries = apiService.fetchCountries();
    _countries.then((data) {
      setState(() {
        _allCountries = data;
        _filteredCountries = data;
      });

    }).catchError((error){
      if (kDebugMode) {
        print('Error fetching countries: $error');
      }
    });
  }

  // Method to filter the countries based on what is typed in the search bar
  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
      setState(() {
        if(query.isEmpty) {
           _filteredCountries = _allCountries;
        } else{
          _filteredCountries = _allCountries.where((country) => country.name.toLowerCase().contains(query)).toList();
        }
      });
  }

  // method to filter the countries based on continent and timezone
  void filterCountries(List<Country> countries) {
    setState(() {
      _filteredCountries = countries.where((country) {
        bool matchesContinent = selectedContinent == null || country.continent == selectedContinent;
        bool matchesTimeZone = selectedTimeZone == null || country.timeZone == selectedTimeZone;
        return matchesContinent && matchesTimeZone;
      }).toList();
    });
  }
  void showFilterDialog(List<Country> countries) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter Countries'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                hint: Text('Select Continent'),
                value: selectedContinent,
                onChanged: (value) {
                  setState(() {
                    selectedContinent = value;
                  });
                  filterCountries(countries);
                },
                items: countries
                    .map((e) => e.continent)
                    .toSet()
                    .map((continent) => DropdownMenuItem(value: continent, child: Text(continent)))
                    .toList(),
              ),
              DropdownButton<String>(
                hint: Text('Select Time Zone'),
                value: selectedTimeZone,
                onChanged: (value) {
                  setState(() {
                    selectedTimeZone = value;
                  });
                  filterCountries(countries);
                },
                items: countries
                    .map((e) => e.timeZone)
                    .toSet()
                    .map((timeZone) => DropdownMenuItem(value: timeZone, child: Text(timeZone)))
                    .toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  selectedContinent = null;
                  selectedTimeZone = null;
                  _filteredCountries = countries;
                });
                Navigator.pop(context);
              },
              child: Text('Reset'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Show Results'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () async {
              List<Country> countries = await _countries;
              showFilterDialog(countries);
            },
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Provider.of<ThemeProvider>(context, listen: false).toogleTheme();
          },
          icon: Icon(Icons.light_mode),),
        title: Text('Countries',
          style: TextStyle(fontWeight: FontWeight.bold),),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search Country',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                ),
                style: TextStyle(color: Colors.black),
                textInputAction: TextInputAction.search,
                onSubmitted: (value){
                  _filterCountries();
                  FocusScope.of(context).unfocus();
                },
              ),
            ),)),
      ),
      body: FutureBuilder<List<Country>>(
        future: _countries,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          } else if(snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'),);
          } else {
           return _filteredCountries.isEmpty
               ? Center(child: Text('No countries found'),)
           :ListView.builder(
                itemCount: _filteredCountries.length,
                itemBuilder: (context, index){
                  final country = _filteredCountries[index];
                  return ListTile(
                    leading: Image.network(country.flag, width: 50,),
                    title: Text(country.name),
                    subtitle: Text('Capital: ${country.capital}'),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CountryDetailScreen(country: country)));
                    },
                  );
                });
          }
        },
      )
    );
  }
}
