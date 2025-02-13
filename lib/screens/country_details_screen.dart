import 'package:flutter/material.dart';

import 'package:globalia/classes/country.dart';

class CountryDetailsScreen extends StatefulWidget {
  final Country country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  State<CountryDetailsScreen> createState() => _CountryDetailsScreenState();
}

class _CountryDetailsScreenState extends State<CountryDetailsScreen> {
  bool showFlag = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.country.name),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Container with Navigation
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Theme.of(context).highlightColor,
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: _buildImage(),
                    ),
                  ),
                ),
                // Navigation Arrows
                if (widget.country.coatOfArmUrl != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showFlag = true;
                          });
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showFlag = false;
                          });
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 24),

            // Details Section
            Expanded(
              child: ListView(
                children: [
                  _buildDetailRow(
                    context: context,
                    title: "Population",
                    value: _formatPopulation(widget.country.population),
                  ),
                  _buildDetailRow(
                    context: context,
                    title: "Capital",
                    value: widget.country.capital,
                  ),
                  _buildDetailRow(
                    context: context,
                    title: "Continent",
                    value: widget.country.continent ?? 'N/A',
                  ),
                  _buildDetailRow(
                    context: context,
                    title: "Country Code",
                    value: widget.country.countryCode ?? 'N/A',
                  ),
                  if (widget.country.timeZone != null &&
                      widget.country.timeZone!.isNotEmpty)
                    _buildDetailRow(
                      context: context,
                      title: "Time Zone",
                      value: widget.country.timeZone!.first,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    String? imageUrl =
        showFlag ? widget.country.flagUrl : widget.country.coatOfArmUrl;

    if (imageUrl != null) {
      return Image.network(
        imageUrl,
        key: ValueKey<String>(imageUrl),
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.contain, // Changed to contain to prevent cropping
        errorBuilder: (context, error, stackTrace) {
          return const SizedBox(
            width: 40,
            height: 30,
            child: Center(
              child: Icon(Icons.broken_image),
            ),
          );
        },
      );
    }

    return const SizedBox(
      width: 40,
      height: 30,
      child: Center(
        child: Icon(Icons.image_not_supported),
      ),
    );
  }

  Widget _buildDetailRow({
    required BuildContext context,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  String _formatPopulation(int? population) {
    if (population == null) return 'N/A';
    if (population >= 1000000) {
      return '${(population / 1000000).toStringAsFixed(1)}M';
    } else if (population >= 1000) {
      return '${(population / 1000).toStringAsFixed(1)}K';
    }
    return population.toString();
  }
}
