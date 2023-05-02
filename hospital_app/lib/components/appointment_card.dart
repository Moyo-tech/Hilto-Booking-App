import 'package:hospital_app/main.dart';
import 'package:hospital_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:hospital_app/provider/appointment_provider.dart';

class AppointmentCard extends StatelessWidget {
  final String appointmentName;
  final String appointmentTime;
  final String specialistType;
  final String appointmentDate;

  AppointmentCard(
      {Key? key,
      required this.appointmentName,
      required this.appointmentTime,
      required this.specialistType,
      required this.appointmentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
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
                  CircleAvatar(
                    backgroundImage: AssetImage(
                        "assets/doctor_1.jpg"), //insert doctor profile
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "$appointmentName",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        "$specialistType",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
              Config.spaceSmall,
              //Schedule info here
              ScheduleCard(
                appointmentTime: appointmentTime,
                appointmentDate: appointmentDate,
              ),
              Config.spaceSmall,
              //action button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Completed',
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
    );
  }
}

//Schedule Widget
class ScheduleCard extends StatelessWidget {
  final String appointmentTime;
  final String appointmentDate;

  const ScheduleCard(
      {Key? key, required this.appointmentTime, required this.appointmentDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Colors.white,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$appointmentDate',
            style: const TextStyle(color: Colors.white),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: Colors.white,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            "$appointmentTime",
            style: const TextStyle(color: Colors.white),
          ))
        ],
      ),
    );
  }
}
