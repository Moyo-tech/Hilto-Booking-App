import 'package:flutter/material.dart';
import 'package:hospital_app/provider/appointment_provider.dart';
import 'package:hospital_app/components/doctor_card.dart';
import 'package:provider/provider.dart';
import 'package:hospital_app/components/appointment_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital_app/utils/config.dart';

class Homepag extends StatefulWidget {
  final String name;
  const Homepag({this.name = ''});

  @override
  State<Homepag> createState() => _HomepagState();
}

class _HomepagState extends State<Homepag> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Home(),
          Categorywidget(),
          Consumer<AppointmentProvider>(
              builder: (context, appointmentProvider, child) {
            if (appointmentProvider.appointmentName.isEmpty) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'No Appointment Today',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return AppointmentCard(
                appointmentName: appointmentProvider.appointmentName,
                appointmentTime: appointmentProvider.appointmentTime,
                specialistType: appointmentProvider.specialistType,
                appointmentDate: appointmentProvider.appointmentDate,

              );
            }
          }),
          DoctorCard(),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> notify = <String>[
      'Your appointment with Dr. Alix Doe has been confirmed',
      'Your test result for Hepatitis B is ready',
      'Your appointment with Dr. Kate Stone has been confirmed',
      'Your appointment with Dr. Alix Doe has been confirmed',
      'Your test result for Hepatitis B is ready',
      'Your appointment with Dr. Kate Stone has been confirmed'
    ];

    final List<String> notifytime = <String>[
      'Booking time 13:30',
      'Time suggested for collection 11:00',
      '4:00',
      'Booking time 13:30',
      'Time suggested for collection 11:00',
      '4:00',
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 34.0),
      child: Row(
        children: [
          Text(
            'Welcome,\nHilda',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0E0255),
            ),
          ),
          Spacer(),
          ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    child: Container(
                      height: 500,
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(
                              'Notifications',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0E0255),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.close,
                                color: Color.fromARGB(255, 164, 16, 16),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          Divider(),
                          Expanded(
                            child: ListView.builder(
                              itemCount: notify.length,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      '${notify[index]}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF0E0255),
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${notifytime[index]}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF0E0255),
                                      ),
                                    ),
                                  ),
                                  Divider(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.notifications,
              size: 30,
              color: Color(0xFF0E0255),
            ),
            label: Text(''),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.transparent),
              elevation: MaterialStateProperty.all<double>(0),
            ),
          ),
        ],
      ),
    );
  }
}

class Categorywidget extends StatelessWidget {
  List<Map<String, dynamic>> medCat = [
    {
      "icon": FontAwesomeIcons.userDoctor,
      "category": "General",
    },
    {
      "icon": FontAwesomeIcons.heartPulse,
      "category": "Cardiology",
    },
    {
      "icon": FontAwesomeIcons.lungs,
      "category": "Respirations",
    },
    {
      "icon": FontAwesomeIcons.hand,
      "category": "Dermatology",
    },
    {
      "icon": FontAwesomeIcons.personPregnant,
      "category": "Gynecology",
    },
    {
      "icon": FontAwesomeIcons.teeth,
      "category": "Dental",
    },
  ];
  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Container(
      margin: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Category',
            style: TextStyle(
              color: Config.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          SizedBox(
            height: Config.heightSize * 0.05,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List<Widget>.generate(medCat.length, (index) {
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  color: Config.primaryColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        FaIcon(
                          medCat[index]['icon'],
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          medCat[index]['category'],
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          SizedBox(
            height: 40.0,
          ),
          const Text(
            'Todays Appointment',
            style: TextStyle(
              color: Config.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

