import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      primaryColor: const Color.fromRGBO(255, 108, 0, 0.8),
      
      // Text Theme
      textTheme: const TextTheme(
        // AppBar Title
        titleLarge: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 32.9/20, // lineHeight / fontSize
          letterSpacing: 0,
          color: Color.fromRGBO(0, 0, 0, 1),
        ),
        // Normal Text
        bodyLarge: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 16,
          fontWeight: FontWeight.w300,
          height: 24.67/16,
          letterSpacing: 0,
          color: Color.fromRGBO(28, 25, 23, 1),
        ),
        // Title Text
        titleMedium: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 25.66/16,
          letterSpacing: 0,
          color: Color.fromRGBO(0, 0, 0, 1),
        ),
        // ListTile Title
        bodyMedium: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 22.18/14,
          letterSpacing: -0.3,
          color: Color.fromRGBO(28, 25, 23, 1),
        ),
        // ListTile Subtitle
        bodySmall: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 22.18/14,
          letterSpacing: -0.3,
          color: Color.fromRGBO(102, 112, 133, 1),
        ),
        // Filter Title
        labelLarge: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 24/16,
          letterSpacing: 0,
        ),
      ),

      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        iconColor: Color.fromRGBO(28, 25, 23, 1),
        minLeadingWidth: 40,
        minVerticalPadding: 20,
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color.fromRGBO(242, 244, 247, 1);
          }
          return const Color.fromRGBO(208, 213, 221, 1);
        }),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromRGBO(0, 15, 36, 1),
      primaryColor: const Color.fromRGBO(255, 108, 0, 0.8),
      
      // Text Theme
      textTheme: const TextTheme(
        // AppBar Title
        titleLarge: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 20,
          fontWeight: FontWeight.w700,
          height: 32.9/20,
          letterSpacing: 0,
          color: Color.fromRGBO(242, 244, 247, 1),
        ),
        // Normal Text
        bodyLarge: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 16,
          fontWeight: FontWeight.w300,
          height: 24.67/16,
          letterSpacing: 0,
          color: Color.fromRGBO(242, 244, 247, 1),
        ),
        // Title Text
        titleMedium: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 25.66/16,
          letterSpacing: 0,
          color: Color.fromRGBO(242, 244, 247, 1),
        ),
        // ListTile Title
        bodyMedium: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 22.18/14,
          letterSpacing: -0.3,
          color: Color.fromRGBO(242, 244, 247, 1),
        ),
        // ListTile Subtitle
        bodySmall: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 22.18/14,
          letterSpacing: -0.3,
          color: Color.fromRGBO(152, 162, 179, 1),
        ),
        // Filter Title
        labelLarge: TextStyle(
          fontFamily: 'Axiforma',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          height: 24/16,
          letterSpacing: 0,
        ),
      ),

      // List Tile Theme
      listTileTheme: const ListTileThemeData(
        iconColor: Color.fromRGBO(242, 244, 247, 1),
        minLeadingWidth: 40,
        minVerticalPadding: 20,
      ),

      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color.fromRGBO(242, 244, 247, 1);
          }
          return const Color.fromRGBO(208, 213, 221, 1);
        }),
      ),

      // Bottom Sheet Theme
      bottomSheetTheme: const BottomSheetThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
      ),
    );
  }
}