import 'package:hospital_app/screens/doctor/doctor_details.dart';
import 'package:hospital_app/main.dart';
import 'package:hospital_app/utils/config.dart';
import 'package:flutter/material.dart';
import '';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> doctorname = [
      'Dr. Smith',
      'Dr. John',
      'Dr. Brown',
      'Dr. Davis',
      'Dr. Garcia',
      'Dr. Wilson',
    ];

    final List<String> doctype = <String>[
      'Dental',
      'Pediatrics',
      'Cardiology',
      'Neurology',
      'Oncology',
      'Plastic Surgery'
    ];

    final List<String> docreviews = <String>[
      "4.5 Reviews",
      "4.3 Reviews",
      "3.5 Reviews",
      "3.8 Reviews",
      "5 Reviews",
      "3.2 Reviews",
    ];
    final List<String> docavatar = <String>[
      'assets/doctor1.jpg',
      'assets/doctor2.jpg',
      'assets/doctor3.jpg',
      'assets/doctor4.jpg',
      'assets/doctor5.jpg',
      'assets/doctor6.jpg',
    ];
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: 20.0, vertical: 10.0), // Add margin here
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Top Doctors",
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Config.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: doctorname.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) => Container(
                  height: 100,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('${docavatar[index]}'),
                    ),
                    title: Text(
                      "${doctorname[index]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "${doctype[index]}",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.yellow[700],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "${docreviews[index]}",
                        ),
                      ],
                    ),
                    onTap: () {
                      // Navigate to the profile screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DoctorDetails(),
                        ),
                      );
                    },
                  ),
                ),
              ))
        ])));
  }
}
