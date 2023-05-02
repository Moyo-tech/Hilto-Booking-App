import 'package:flutter/foundation.dart';

class AppointmentProvider extends ChangeNotifier {
  String _appointmentName = '';
  String _appointmentTime = '';
  String _specialistType = '';
  String _appointmentDate = ''; // Add new field
  String _diagnosis = '';
  String _report = '';

  String get diagnosis => _diagnosis;

  set diagnosis(String newDiagnosis) {
    _diagnosis = newDiagnosis;
    notifyListeners();
  }

  String get report => _report;

  set report(String newReport) {
    _report = newReport;
    notifyListeners();
  }


  String get appointmentName => _appointmentName;

  set appointmentName(String newName) {
    _appointmentName = newName;
    notifyListeners();
  }
  String get appointmentTime => _appointmentTime;

  set appointmentTime(String newTime) {
    _appointmentTime = newTime;
    notifyListeners();
  }
  String get specialistType => _specialistType;

  set specialistType(String newSpecialistType) {
    _specialistType = newSpecialistType;
    notifyListeners();
  }
  String get appointmentDate => _appointmentDate;

  set appointmentDate(String newDate) {
    _appointmentDate = newDate;
    notifyListeners();
  }
  void removeAppointment() {
    _appointmentName = '';
    _appointmentTime = '';
    _specialistType = '';
    _appointmentDate = '';
    notifyListeners();
  }


  }
