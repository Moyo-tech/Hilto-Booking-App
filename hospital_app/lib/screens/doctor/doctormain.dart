import 'package:flutter/material.dart';
import 'package:hospital_app/screens/doctor/doctorappointment.dart';
import 'package:hospital_app/screens/doctor/doctorhome.dart';
import 'package:hospital_app/screens/doctor/doctorprofile.dart';



class DoctorPage extends StatefulWidget {
  const DoctorPage({super.key, required this.title});

  final String title;

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  int _selectedIndex = 0;

  List<Widget> _screens = [Homepag2(), DoctorProfile(), Appointment2()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF0E0255),
        selectedFontSize: 13,
        unselectedFontSize: 13,
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: "Appointment",
            icon: Icon(Icons.medical_information_rounded),
          ),
        ],
        onTap: (i) {
          setState(() {
            _selectedIndex = i;
          });
        },
        currentIndex: _selectedIndex,
      ),
    );
  }
}
