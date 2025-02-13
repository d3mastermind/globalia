import 'package:flutter/material.dart';
import 'package:globalia/classes/country.dart';
import 'package:globalia/services/country_service.dart';
import 'package:globalia/widgets/country_tile.dart';
import 'package:globalia/widgets/filter_bottom_sheet.dart';

class CountryListScreen extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDarkMode;

  const CountryListScreen({
    super.key,
    required this.toggleTheme,
    required this.isDarkMode,
  });

  @override
  CountryListScreenState createState() => CountryListScreenState();
}

class CountryListScreenState extends State<CountryListScreen> {
  String searchQuery = '';
  Set<String> selectedContinents = {};
  Set<String> selectedTimeZones = {};
  List<Country> countries = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchCountries();
  }

  Future<void> fetchCountries() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final fetchedCountries = await CountryService.fetchCountries();
      setState(() {
        countries = fetchedCountries;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error =
            'Failed to load countries. Please check your internet connection.';
        isLoading = false;
      });
    }
  }

  Set<String> get availableContinents =>
      countries.map((c) => c.continent ?? 'Unknown').toSet();

  Set<String> get availableTimeZones {
    Set<String> zones = {};
    for (var country in countries) {
      if (country.timeZone != null) {
        zones.addAll(country.timeZone!);
      }
    }
    return zones;
  }

  List<Country> getFilteredCountries() {
    return countries.where((country) {
      bool matchesSearch = country.name.toLowerCase().contains(searchQuery);
      bool matchesContinent = selectedContinents.isEmpty ||
          (country.continent != null &&
              selectedContinents.contains(country.continent));
      bool matchesTimeZone = selectedTimeZones.isEmpty ||
          (country.timeZone?.any((tz) => selectedTimeZones.contains(tz)) ??
              false);

      return matchesSearch && matchesContinent && matchesTimeZone;
    }).toList();
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            error ?? 'An error occurred',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: fetchCountries,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading countries...'),
        ],
      ),
    );
  }

  Widget _buildCountryList() {
    List<Country> filteredCountries = getFilteredCountries();
    Map<String, List<Country>> groupedCountries = {};

    for (var country in filteredCountries) {
      String letter = country.name[0].toUpperCase();
      groupedCountries.putIfAbsent(letter, () => []).add(country);
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Country',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              setState(() {
                searchQuery = value.toLowerCase();
              });
            },
          ),
        ),
        if (!isLoading && error == null)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 100,
                child: Row(
                  children: [
                    Text("Filter"),
                    IconButton(
                      icon: const Icon(Icons.filter_list),
                      onPressed: _showFilterDialog,
                    ),
                  ],
                ),
              ),
            ],
          ),
        if (selectedContinents.isNotEmpty || selectedTimeZones.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const Text('Active filters: '),
                Expanded(
                  child: Wrap(
                    spacing: 4,
                    children: [
                      ...selectedContinents.map((c) => Chip(
                            label: Text(c),
                            onDeleted: () =>
                                setState(() => selectedContinents.remove(c)),
                          )),
                      ...selectedTimeZones.map((tz) => Chip(
                            label: Text(tz),
                            onDeleted: () =>
                                setState(() => selectedTimeZones.remove(tz)),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: groupedCountries.isEmpty
              ? const Center(
                  child: Text('No countries found'),
                )
              : ListView(
                  children: groupedCountries.keys.map((letter) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            letter,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        ...groupedCountries[letter]!
                            .map((country) => CountryTile(country: country)),
                      ],
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => FilterBottomSheet(
        selectedContinents: selectedContinents,
        selectedTimeZones: selectedTimeZones,
        availableContinents: availableContinents,
        availableTimeZones: availableTimeZones,
        onApplyFilters: (continents, timezones) {
          setState(() {
            selectedContinents = continents;
            selectedTimeZones = timezones;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: widget.isDarkMode
            ? Image.asset('assets/images/logo.png', height: 40)
            : Image.asset('assets/images/ex_logo.png', height: 55),
        actions: [
          IconButton(
            icon: Icon(
              widget.isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              size: 25,
            ),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchCountries,
        child: isLoading
            ? _buildLoadingWidget()
            : error != null
                ? _buildErrorWidget()
                : _buildCountryList(),
      ),
    );
  }
}
