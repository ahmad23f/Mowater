import 'package:json_annotation/json_annotation.dart';

part 'plate_model.g.dart'; // This will be generated by the build runner

@JsonSerializable() // Annotation to indicate that this class will be used for JSON serialization
class PlateModelForSale {
  final int id;
  final String source;
  final String code;
  final String owner;
  final String whatsApp;
  final String phoneNmber;
  final String price;
  final DateTime postAt;
  final int isNegotiable;
  final String plateNumber;
  final int isApproved;
  PlateModelForSale({
    required this.isApproved,
    required this.id,
    required this.source,
    required this.code,
    required this.owner,
    required this.whatsApp,
    required this.phoneNmber,
    required this.price,
    required this.postAt,
    required this.isNegotiable,
    required this.plateNumber,
  });

  // A factory constructor to create a PlateModel instance from a JSON object
  factory PlateModelForSale.fromJson(Map<String, dynamic> json) =>
      _$PlateModelForSaleFromJson(json);

  // A method to convert a PlateModel instance to a JSON object
  Map<String, dynamic> toJson() => _$PlateModelForSaleToJson(this);
}