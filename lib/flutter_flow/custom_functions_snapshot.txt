import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/auth/firebase_auth/auth_util.dart';

List<String> newCustomFunction(
  String name,
  String brand,
) {
  List<String> keywords = [];

  for (int i = 1; i <= name.length; i++) {
    String substring = name.substring(0, i);
    keywords.add('');
    keywords.add(substring.toLowerCase()); // lowercase
    keywords.add(substring.toUpperCase()); // uppercase
    keywords.add(substring[0].toUpperCase() +
        substring.substring(1).toLowerCase()); // Capitalized
  }

  for (int i = 1; i <= brand.length; i++) {
    keywords.add('');
    String substring = brand.substring(0, i);
    keywords.add(substring.toLowerCase());
    keywords.add(substring.toUpperCase());
    keywords
        .add(substring[0].toUpperCase() + substring.substring(1).toLowerCase());
  }

  return keywords;
}
