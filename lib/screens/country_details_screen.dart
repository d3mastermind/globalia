import 'package:flutter/material.dart';
import 'package:globalia/classes/country.dart';

class CountryDetailsScreen extends StatelessWidget {
  final Country country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).highlightColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Center(
                  child: country.flagUrl != null
                      ? Image.network(
                          country.flagUrl!,
                          width: double.infinity,
                          //height: 30,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              width: 40,
                              height: 30,
                              child: Center(
                                child: Icon(Icons.broken_image),
                              ),
                            );
                          },
                        )
                      : const SizedBox(
                          width: 40,
                          height: 30,
                          child: Center(
                            child: Icon(Icons.image_not_supported),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text("Name: ${country.name}", style: _textStyle()),
            Text("Population: ${country.population}", style: _textStyle()),
            Text("Capital City: ${country.capital}", style: _textStyle()),
            Text("Continent: ${country.continent}", style: _textStyle()),
            Text("Country Code: ${country.countryCode}", style: _textStyle()),
          ],
        ),
      ),
    );
  }

  TextStyle _textStyle() {
    return const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  }
}
