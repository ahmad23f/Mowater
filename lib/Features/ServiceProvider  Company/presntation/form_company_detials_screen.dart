import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mowaterApp/Features/ServiceProvider%20%20Company/model/service_account.dart';
import 'package:mowaterApp/Features/ServiceProvider%20%20Company/presntation/widgets/day_week_dialgo.dart';
import 'package:mowaterApp/Features/serviceProverAuth/presnation/widgets/specialty_drop_down.dart';
import 'package:mowaterApp/core/constants/color.dart';
import 'package:mowaterApp/core/widgets/button.dart';
import 'package:mowaterApp/core/widgets/snak_bar.dart';
import 'package:mowaterApp/core/widgets/text_form_fiedl.dart';
import 'package:permission_handler/permission_handler.dart';

class ServiceProviderChoseTypeAccountScreen extends StatefulWidget {
  const ServiceProviderChoseTypeAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  _ServiceProviderChoseTypeAccountScreenState createState() =>
      _ServiceProviderChoseTypeAccountScreenState();
}

class _ServiceProviderChoseTypeAccountScreenState
    extends State<ServiceProviderChoseTypeAccountScreen> {
  late TextEditingController tradeNameController;
  late TextEditingController commercialLicenseNumberController;
  File? _image;
  File? _pdfFile;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  double? latitude;
  double? longitude;
  List<String> selectedDays = [];
  String? selectedSpecialties = 'Maintenance';

  @override
  void initState() {
    super.initState();
    tradeNameController = TextEditingController();
    commercialLicenseNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Company Information',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                _selectFile(FileType.image);
              },
              child: Center(
                child: Container(
                  width: 120.w,
                  height: 120.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: _image != null
                      ? ClipOval(
                          child: Image.file(
                            _image!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Stack(
                          children: [
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: 0,
                              top: 0,
                              child: Icon(
                                Icons.store_outlined,
                                size: 70.dg,
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 10,
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.all(5.dg),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: ColorApp.secunderyColorDark,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    size: 20,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                ),
              ),
            ),
            SizedBox(height: 12.h), // Add spacing
            Text(
              'Trade Name',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomTextFormField(
              controller: tradeNameController,
              hintText: 'Trade Name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Trade Name is required';
                }
                return null;
              },
            ),
            SizedBox(height: 12.h),
            Text(
              'Commercial License Number',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            CustomTextFormField(
              controller: commercialLicenseNumberController,
              hintText: 'Commercial license number',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Commercial license number is required';
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Service Specialty',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SpecialtyDropDown(
              selectedValue: selectedSpecialties,
              onChanged: (specialty) {
                setState(() {
                  selectedSpecialties = specialty!;
                });
              },
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Text(
                  'work days',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      List<String>? result = await showDialog(
                        context: context,
                        builder: (context) => const DayWeekDialog(),
                      );
                      if (result != null) {
                        setState(() {
                          selectedDays = result;
                        });
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0.dg, horizontal: 5.dg),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorApp.secunderyColorDark,
                      ),
                      child: Text(
                        selectedDays.isEmpty
                            ? 'Days work'
                            : selectedDays.join(', '),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Time',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null && pickedTime != startTime) {
                            setState(() {
                              endTime = pickedTime;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorApp.secunderyColorDark,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                endTime != null
                                    ? _formatTime(endTime!)
                                    : 'Select',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                startTime != null
                                    ? _getPeriod(endTime ??
                                        const TimeOfDay(hour: 0, minute: 0))
                                    : '',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  'To',
                  style: TextStyle(
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Time',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null && pickedTime != startTime) {
                            setState(() {
                              startTime = pickedTime;
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 10.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorApp.secunderyColorDark,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                startTime != null
                                    ? _formatTime(startTime!)
                                    : 'Select',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                              Text(
                                startTime != null ? _getPeriod(startTime!) : '',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),

            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      return showDialog(
                        context: context,
                        builder: (context) => MapPickerDialog(
                          onSelected: (LatLng location) {
                            setState(() {
                              latitude = location.latitude;
                              longitude = location.longitude;
                            });
                          },
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: ColorApp.secunderyColorDark,
                          borderRadius: BorderRadius.circular(12.dg)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.map_outlined),
                          Text(
                            latitude != null && longitude != null
                                ? 'Location Selected'
                                : 'Select Location on Map',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16.0.sp),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 150.h,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _selectFile(FileType.custom,
                                        allowedExtensions: ['pdf']);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Upload pdf',
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _selectFile(FileType.any);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Choose from Gallery',
                                      style: TextStyle(
                                          fontSize: 16.sp, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.file_upload_outlined),
                        Container(
                          padding: EdgeInsets.all(10.0.dg),
                          child: _pdfFile != null
                              ? Text(
                                  'Attachment Selected',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0.sp),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Upload  a ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                    Text(
                                      'Attachment',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          color: ColorApp.primeryColorDark),
                                    ),
                                  ],
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    onPressed: () {
                      if (_validateInputs()) {
                        // All inputs are valid, proceed with account creation
                        _createAccount();
                      }
                    },
                    color: ColorApp.primeryColorDark,
                    textStyle: TextStyle(fontSize: 18.sp, color: Colors.white),
                    text: 'Create Account',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (_image == null) {
      ShowSnakBar(
        context,
        content: 'Please select an image',
        title: 'Failur',
        backGroundColor: const Color.fromARGB(255, 98, 22, 18),
      );
      return false;
    }
    if (tradeNameController.text.isEmpty) {
      ShowSnakBar(
        context,
        content: 'Trade Name is required',
        title: 'Failur',
        backGroundColor: const Color.fromARGB(255, 98, 22, 18),
      );
      return false;
    }
    if (commercialLicenseNumberController.text.isEmpty) {
      ShowSnakBar(
        context,
        content: 'Commercial license number is required',
        title: 'Failur',
        backGroundColor: const Color.fromARGB(255, 98, 22, 18),
      );
      return false;
    }
    if (selectedDays.isEmpty) {
      ShowSnakBar(
        context,
        content: 'Please select work days',
        title: 'Failur',
        backGroundColor: const Color.fromARGB(255, 98, 22, 18),
      );
      return false;
    }
    if (startTime == null || endTime == null) {
      ShowSnakBar(
        context,
        content: 'Please select work timings',
        title: 'Failur',
        backGroundColor: const Color.fromARGB(255, 98, 22, 18),
      );
      return false;
    }
    if (latitude == null || longitude == null) {
      ShowSnakBar(
        context,
        content: 'Please select a location on map',
        title: 'Failur',
        backGroundColor: const Color.fromARGB(255, 98, 22, 18),
      );
      return false;
    }
    return true;
  }

  void _createAccount() {
    // Logic to create account goes here
    // You can access all the selected values here and process them
    // For example: tradeNameController.text, commercialLicenseNumberController.text, selectedDays, selectedSpecialties, etc.
    ServiceProviderAccountModel serviceProviderAccount =
        ServiceProviderAccountModel(
      image: _image,
      tradeName: tradeNameController.text,
      commercialLicenseNumber: commercialLicenseNumberController.text,
      selectedSpecialties: selectedSpecialties!,
      selectedDays: selectedDays,
      startTime: startTime,
      endTime: endTime,
      latitude: latitude,
      longitude: longitude,
      pdfFile: _pdfFile,
    );

    // Now you can use serviceProviderAccount to save or process the data as needed.
  }

  Future<void> _selectFile(FileType type,
      {List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type,
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      setState(() {
        if (type == FileType.image) {
          _image = File(result.files.single.path!);
        } else {
          _pdfFile = File(result.files.single.path!);
        }
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _getPeriod(TimeOfDay time) {
    return time.period == DayPeriod.am ? 'AM' : 'PM';
  }
}

class MapPickerDialog extends StatefulWidget {
  final void Function(LatLng)? onSelected;

  const MapPickerDialog({Key? key, this.onSelected}) : super(key: key);

  @override
  _MapPickerDialogState createState() => _MapPickerDialogState();
}

class _MapPickerDialogState extends State<MapPickerDialog> {
  LatLng? _currentLocation;
  LatLng? _markerLocation;
  bool _isLoading = true;
  late GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick Location on Map'),
      content: SizedBox(
        width: 300, // Take up full width
        height: 300,
        child: Stack(
          children: [
            if (_currentLocation != null)
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _currentLocation!,
                  zoom: 15,
                ),
                onTap: _pickLocation,
                markers: _markerLocation != null
                    ? {
                        Marker(
                            markerId: const MarkerId('selected'),
                            position: _markerLocation!)
                      }
                    : {},
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                onCameraMove: (position) {
                  _markerLocation = position.target;
                  setState(() {});
                },
              ),
            if (_isLoading) const Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle saving the selected location
            if (_markerLocation != null) {
              // Invoke the callback with the selected location
              if (widget.onSelected != null) {
                widget.onSelected!(_markerLocation!);
                print(_currentLocation);
              }
            }
            Navigator.of(context).pop();
          },
          child: const Text('Select'),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    PermissionStatus permission = await Permission.location.request();
    if (permission == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        setState(() {
          _currentLocation = LatLng(position.latitude, position.longitude);
          _isLoading = false; // Stop showing loading indicator
          _markerLocation =
              _currentLocation; // Initially set marker to current location
        });
      } catch (e) {
        print("Error getting current location: $e");
        _isLoading = false; // Stop showing loading indicator
      }
    } else {
      print("Location permission denied by user");
      _isLoading = false; // Stop showing loading indicator
    }
  }

  void _pickLocation(LatLng latLng) {
    setState(() {
      _markerLocation = latLng;
      _mapController.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }
}
