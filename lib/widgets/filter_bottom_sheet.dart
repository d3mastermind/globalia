import 'dart:math' show min;
import 'package:flutter/material.dart';

class FilterBottomSheet extends StatefulWidget {
  final Set<String> selectedContinents;
  final Set<String> selectedTimeZones;
  final Set<String> availableContinents;
  final Set<String> availableTimeZones;
  final Function(Set<String>, Set<String>) onApplyFilters;

  const FilterBottomSheet({
    super.key,
    required this.selectedContinents,
    required this.selectedTimeZones,
    required this.availableContinents,
    required this.availableTimeZones,
    required this.onApplyFilters,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  late Set<String> _selectedContinents;
  late Set<String> _selectedTimeZones;
  bool _isContinentExpanded = false;
  bool _isTimeZoneExpanded = false;

  bool get _hasSelectedFilters =>
      _selectedContinents.isNotEmpty || _selectedTimeZones.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _selectedContinents = Set.from(widget.selectedContinents);
    _selectedTimeZones = Set.from(widget.selectedTimeZones);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: theme.textTheme.labelLarge,
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: theme.listTileTheme.iconColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _getExpandedHeight(),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildExpandableSection(
                    title: 'Continent',
                    isExpanded: _isContinentExpanded,
                    onTap: () => setState(() {
                      _isContinentExpanded = !_isContinentExpanded;
                      if (_isContinentExpanded) {
                        _isTimeZoneExpanded = false;
                      }
                    }),
                    children: widget.availableContinents.map((continent) {
                      return CheckboxListTile(
                        title: Text(
                          continent,
                          style: theme.textTheme.bodyMedium,
                        ),
                        value: _selectedContinents.contains(continent),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value ?? false) {
                              _selectedContinents.add(continent);
                            } else {
                              _selectedContinents.remove(continent);
                            }
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                      );
                    }).toList(),
                  ),
                  _buildExpandableSection(
                    title: 'Time Zone',
                    isExpanded: _isTimeZoneExpanded,
                    onTap: () => setState(() {
                      _isTimeZoneExpanded = !_isTimeZoneExpanded;
                      if (_isTimeZoneExpanded) {
                        _isContinentExpanded = false;
                      }
                    }),
                    children: widget.availableTimeZones.map((timezone) {
                      return CheckboxListTile(
                        title: Text(
                          timezone,
                          style: theme.textTheme.bodyMedium,
                        ),
                        value: _selectedTimeZones.contains(timezone),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value ?? false) {
                              _selectedTimeZones.add(timezone);
                            } else {
                              _selectedTimeZones.remove(timezone);
                            }
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          if (_hasSelectedFilters)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _selectedContinents.clear();
                          _selectedTimeZones.clear();
                        });
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.white, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Reset',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        widget.onApplyFilters(
                          _selectedContinents,
                          _selectedTimeZones,
                        );
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFFF6C00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(
                        'Show results',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildExpandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            title,
            style: theme.textTheme.titleMedium,
          ),
          trailing: Icon(
            isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
            color: theme.listTileTheme.iconColor,
          ),
          onTap: onTap,
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox(height: 0),
          secondChild: Column(children: children),
          crossFadeState:
              isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }

  double _getExpandedHeight() {
    if (_isContinentExpanded) {
      return min(widget.availableContinents.length * 56.0 + 100, 300);
    }
    if (_isTimeZoneExpanded) {
      return min(widget.availableTimeZones.length * 56.0 + 100, 300);
    }
    return 120;
  }
}
