import 'dart:io';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ServiceProviderAccountModel {
  final File? image;
  final String tradeName;
  final String commercialLicenseNumber;
  final String selectedSpecialties;
  final List<String> selectedDays;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final double? latitude;
  final double? longitude;
  final File? pdfFile;

  ServiceProviderAccountModel({
    required this.image,
    required this.tradeName,
    required this.commercialLicenseNumber,
    required this.selectedSpecialties,
    required this.selectedDays,
    required this.startTime,
    required this.endTime,
    required this.latitude,
    required this.longitude,
    required this.pdfFile,
  });
}
