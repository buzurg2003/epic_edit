import 'package:epic_edit/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SnackBarUtils {
  static void showSnackbar(
      BuildContext context, 
      IconData icon, 
      String message
    ) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              icon, 
              color: AppTheme.accent,
            ),
            SizedBox(width: 8),
            Text(message),
          ],
        ),
      ),
    );
  }
}
