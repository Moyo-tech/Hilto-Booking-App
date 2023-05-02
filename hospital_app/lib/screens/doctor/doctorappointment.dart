import 'package:hospital_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hospital_app/components/appointment_card.dart';
import 'package:hospital_app/provider/appointment_provider.dart';

class Appointment2 extends StatefulWidget {
  @override
  Appointment2State createState() => Appointment2State();
}

class Appointment2State extends State<Appointment2> {
  bool _isMyAppointmentsVisible = true;

  void handleCancel(int index) {
    setState(() {
      _isMyAppointmentsVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Header(),
          AppointmentCard2(),
          Consumer<AppointmentProvider>(
              builder: (context, appointmentProvider, child) {
            if (appointmentProvider.appointmentName.isEmpty) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            } else {
              return MyAppointments(
                appointmentName: appointmentProvider.appointmentName,
                appointmentTime: appointmentProvider.appointmentTime,
                specialistType: appointmentProvider.specialistType,
                appointmentDate: appointmentProvider.appointmentDate,
              );
            }
          }),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          // The first container that contains the blue background
          Container(
            height: 150,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0E0255),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
          ),

          // The second container that contains the white background
          Positioned(
            top: 0,
            left: 0,
            right: 40,
            bottom: 30,
            child: Container(
              height: 100,

              // create the width of the container to be the same as the parent
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
          ),

          // The third container that contains the title
          Positioned(
            top: 50,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Appointments',
                  style: TextStyle(
                    color: Color(0xFF0E0255),
                    fontSize: 24,
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyAppointments extends StatefulWidget {
  final String appointmentName;
  final String appointmentTime;
  final String specialistType;
  final String appointmentDate;

  MyAppointments(
      {Key? key,
      required this.appointmentName,
      required this.appointmentTime,
      required this.specialistType,
      required this.appointmentDate})
      : super(key: key);

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  bool isVisible = true;

  void handleCancel() {
    setState(() {
      isVisible = false;
    });
  }

  void handleCheck() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment accepted'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Config.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  //insert Row here
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Hilda Douka",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "${widget.specialistType}",
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                  Config.spaceSmall,
                  //Schedule info here
                  ScheduleCard(
                    appointmentTime: widget.appointmentTime,
                    appointmentDate: widget.appointmentDate,
                  ),
                  Config.spaceSmall,
                  //action button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            handleCheck();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            'Reject',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            handleCancel();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class AppointmentCard2 extends StatefulWidget {
  AppointmentCard2({
    Key? key,
  }) : super(key: key);

  @override
  State<AppointmentCard2> createState() => _AppointmentCard2State();
}

class _AppointmentCard2State extends State<AppointmentCard2> {
  bool isVisible = true;
  void handleCancel() {
    setState(() {
      isVisible = false;
    });
  }

  void handleCheck() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Appointment accepted'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isVisible,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Config.primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  //insert Row here
                  Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Kundai Chasinda",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            "Dental",
                            style: const TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ],
                  ),
                  Config.spaceSmall,
                  //Schedule info here
                  ScheduleCard(
                    appointmentTime: "12:00",
                    appointmentDate: "Sunday 5/1/2023",
                  ),
                  Config.spaceSmall,
                  //action button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text(
                            'Accept',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            handleCheck();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          onPressed: () {
                            handleCancel();
                          },
                          child: const Text(
                            'Reject',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
