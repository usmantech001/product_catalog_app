import 'package:flutter/material.dart';
Widget customIcon({required IconData icon, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: CircleAvatar(backgroundColor: Colors.grey.shade100, child: Icon(icon)));
}
