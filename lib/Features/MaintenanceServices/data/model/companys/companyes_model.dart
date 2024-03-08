import 'package:json_annotation/json_annotation.dart';

part 'companyes_model.g.dart';

@JsonSerializable()
class MaintenanceCompanyModel {
  int? id;
  String? name;
  @JsonKey(name: 'weekday_work')
  String? weekdayWork;
  @JsonKey(name: 'start_time')
  String? startTime;
  @JsonKey(name: 'end_time')
  String? endTime;
  int specialty;
  String? description;
  String? location;
  String? phoneNumber;
  @JsonKey(name: 'WhatsAppNumber')
  String? whatsappNumber;
  @JsonKey(name: "company_image")
  String? image;
  @JsonKey(name: "category_name")
  String? categoryName;
  @JsonKey(name: 'car_brands')
  List<String> carMakes;
  String? latitude;
  String? longitude;
  MaintenanceCompanyModel({
    required this.latitude,
    required this.longitude,
    required this.carMakes,
    required this.categoryName,
    required this.image,
    required this.id,
    required this.name,
    required this.weekdayWork,
    required this.startTime,
    required this.endTime,
    required this.specialty,
    required this.description,
    required this.location,
    required this.phoneNumber,
    required this.whatsappNumber,
  });

  factory MaintenanceCompanyModel.fromJson(Map<String, dynamic> json) =>
      _$MaintenanceCompanyModelFromJson(json);

  Map<String, dynamic> toJson() => _$MaintenanceCompanyModelToJson(this);
}
