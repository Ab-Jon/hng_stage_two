import 'package:flutter/material.dart';
import '../models/country.dart';


class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(country.name),),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(country.flag, width: 500,),
              SizedBox(height: 16,),
              Row(children:[Text('Code: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(country.code, style: TextStyle(fontSize: 18))]),
              Row(children: [Text('Capital: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(country.capital, style: TextStyle(fontSize: 18),)
              ]),
              SizedBox(height: 10,),
              Text('Population: ${country.population}', style: TextStyle(fontSize: 18),),
              Row(children: [
                Text('Religion: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(country.religion, style: TextStyle(fontSize: 18),)]),
              Row(children:[
                Text('Motto: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(country.motto, style: TextStyle(fontSize: 18),)]),
              Row(children: [
                Text('Official Language: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(country.officialLanguage, style: TextStyle(fontSize: 18),)]),
              SizedBox(height: 10,),
              Text('Area: ${country.area}', style: TextStyle(fontSize: 18),),
              Row(children: [
                Text('Independence: ${country.independence}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),]),
              Row(children: [
                Text('Currency: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(country.currency, style: TextStyle(fontSize: 18),)]),
              Text('Time Zone: ${country.timeZone}', style: TextStyle(fontSize: 18),),
              Row(children: [
                Text('Date Format: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(country.dateFormat, style: TextStyle(fontSize: 18),)]),
              Row(children: [
                Text('Driving Code: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                Text(country.drivingSide, style: TextStyle(fontSize: 18),)]),
            ],
          ),
      ),
    );
  }
}
