import 'package:flutter/material.dart';
import 'package:globalia/classes/country.dart';
import 'package:globalia/screens/country_details_screen.dart';

class CountryTile extends StatelessWidget {
  final Country country;

  const CountryTile({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        country.emojiFlag,
        style: TextStyle(fontSize: 50),
        textAlign: TextAlign.center,
      ),
      title: Text(country.name, style: Theme.of(context).textTheme.bodyMedium),
      subtitle:
          Text(country.capital, style: Theme.of(context).textTheme.bodySmall),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CountryDetailsScreen(country: country),
          ),
        );
      },
    );
  }
}
