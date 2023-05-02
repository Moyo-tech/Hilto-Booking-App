import 'package:hospital_app/screens/patient/appointment.dart';
import 'package:hospital_app/components/button.dart';
import 'package:hospital_app/utils/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hospital_app/components/custom_appbar.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({Key? key}) : super(key: key);

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  Map<String, dynamic> doctor = {};
  bool isFav = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appTitle: 'Doctor Details',
        icon: const FaIcon(Icons.arrow_back_ios),
        actions: [
          //Favarite Button
          IconButton(
            //press this button to add/remove favorite doctor
            onPressed: () async {
              //get latest favorite list from auth model
            },
            icon: FaIcon(
              isFav ? Icons.favorite_rounded : Icons.favorite_outline,
              color: Colors.red,
            ),
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            AboutDoctor(
              doctor: doctor,
            ),
            DetailBody(
              doctor: doctor,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Button(
                width: double.infinity,
                title: 'Book Appointment',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Appointment(),
                    ),
                  );
                },
                disable: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AboutDoctor extends StatelessWidget {
  const AboutDoctor({Key? key, required this.doctor}) : super(key: key);

  final Map<dynamic, dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 65.0,
            backgroundImage: AssetImage("assets/doctor1.jpg"),
            backgroundColor: Colors.white,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Dr Smith",
            style: const TextStyle(
              color: Colors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'MBBS (International Medical University, Malaysia), MRCP (Royal College of Physicians, United Kingdom)',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
          Config.spaceSmall,
          SizedBox(
            width: Config.widthSize * 0.75,
            child: const Text(
              'Sarawak General Hospital',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  const DetailBody({Key? key, required this.doctor}) : super(key: key);
  final Map<dynamic, dynamic> doctor;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 5,
          ),
          DoctorInfo(),
          Config.spaceMedium,
          const Text(
            'About Doctor',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: // specify the padding here

                  Text(
                'Dr. Smith is a skilled dental practitioner with 12 years of experience. He offers top-quality care in general, cosmetic, restorative, and orthodontic procedures. Dr. Smith prioritizes patient comfort and satisfaction, providing personalized treatment plans tailored to individual needs.',
                style: const TextStyle(
                  fontWeight: FontWeight.w300,
                  height: 1.5,
                ),
                softWrap: true,
                textAlign: TextAlign.left,
              ))
        ],
      ),
    );
  }
}

class DoctorInfo extends StatelessWidget {
  const DoctorInfo({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        InfoCard(
          label: 'Patients',
          value: '24',
        ),
        const SizedBox(
          width: 15,
        ),
        InfoCard(
          label: 'Experiences',
          value: '12 years',
        ),
        const SizedBox(
          width: 15,
        ),
        const InfoCard(
          label: 'Rating',
          value: '4.5',
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Config.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: Column(
          children: <Widget>[
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
