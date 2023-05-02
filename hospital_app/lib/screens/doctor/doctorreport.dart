import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hospital_app/provider/appointment_provider.dart';
import 'package:hospital_app/utils/config.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DoctorReportScreen extends StatefulWidget {
  const DoctorReportScreen({Key? key}) : super(key: key);

  @override
  _DoctorReportScreenState createState() => _DoctorReportScreenState();
}

class _DoctorReportScreenState extends State<DoctorReportScreen> {
  String? _selectedAge;
  String? _selectedGender;

  final List<String> _ageRanges = [
    '0-10',
    '11-20',
    '21-30',
    '31-40',
    '41-50',
    '51-60',
    '61-70',
    '71+',
  ];

  final List<String> _genders = [
    'Male',
    'Female',
    'Other',
  ];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _diagnosisController = TextEditingController();
  TextEditingController _reportController = TextEditingController();
  List<File> _documents = [];

// Define the list of age ranges
  List<String> ageRanges = [
    '0-10',
    '11-20',
    '21-30',
    '31-40',
    '41-50',
    '51-60',
    '61-70',
    '71-80',
    '81-90',
    '91-100'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _diagnosisController.dispose();
    _reportController.dispose();
    super.dispose();
  }

  String url = "";
  int? number;

  uploadDocument() async {
    // implement your document upload logic here
    number = Random().nextInt(10);
    //pick pdf file
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    File pick = File(result!.files.single.path.toString());
    var file = pick.readAsBytes();
    String name = DateTime.now().millisecondsSinceEpoch.toString();

    //uploading file to firebase
    var pdfFile = FirebaseStorage.instance.ref().child(name).child("/.pdf");
    UploadTask task = pdfFile.putData(await file);
    TaskSnapshot snapshot = await task;
    url = await snapshot.ref.getDownloadURL();

    //upload url to cloud firebase
    await FirebaseFirestore.instance
        .collection("file")
        .doc()
        .set({'fileUrl': url, 'num': 'Dental Report #' + number.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Doctor Report'),
          backgroundColor: Config.primaryColor,
        ),
        body: Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Stack(children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                      padding: EdgeInsets.all(20.0),
                      width: 345,
                      height: 155,
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 139, 127, 199),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                    ),
                    Positioned(
                        left: 125.0,
                        top: 40.0,
                        child: CircleAvatar(
                          backgroundImage: AssetImage('assets/hild.png'),
                          radius: 40.0,
                        )),
                  ]),
                  const Text(
                    'Patient Information',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Config.primaryColor),
                  ),
                  Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(children: [
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _ageController,
                                decoration: const InputDecoration(
                                  labelText: 'Age',
                                ),
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: TextField(
                                controller: _genderController,
                                decoration: const InputDecoration(
                                  labelText: 'Gender',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ])),
                  SizedBox(height: 32.0),
                  const Text(
                    'Diagnosis',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Config.primaryColor),
                  ),
                  Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(children: [
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: _diagnosisController,
                          maxLines: 3,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter diagnosis here',
                          ),
                        ),
                      ])),
                  const SizedBox(height: 32.0),
                  const Text(
                    'Report',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Config.primaryColor),
                  ),
                  Container(
                      margin: EdgeInsets.all(10.0),
                      child: Column(children: [
                        const SizedBox(height: 16.0),
                        TextField(
                          controller: _reportController,
                          maxLines: 10,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter report here',
                          ),
                        ),
                      ])),
                  const SizedBox(height: 32.0),
                  const Text(
                    'Documents',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: uploadDocument,
                    child: const Text('Upload Document', 
                     ),
                    
                  ),
                  SizedBox(height: 20),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('file')
                        .snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                            child: SizedBox(
                          height: 150,
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              QueryDocumentSnapshot data =
                                  snapshot.data!.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => View(
                                                url: data['fileUrl'],
                                              )));
                                },
                                child: Container(
                                  width: 123,
                                  margin: EdgeInsets.fromLTRB(0, 0, 20.0, 20.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Color.fromARGB(255, 139, 127, 199)),
                                    color: Color.fromARGB(255, 139, 127, 199),

                                    boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 4,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.picture_as_pdf),
                                      SizedBox(height: 10),
                                      Text(data['num']),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ));
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 100.0),
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xFF0E0255),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    //  The text buton which does nothing on pressed
                    child: TextButton(
                        onPressed: () {
                          final appointmentProvider =
                              Provider.of<AppointmentProvider>(context,
                                  listen: false);
                          appointmentProvider.diagnosis =
                              _diagnosisController.text;
                          appointmentProvider.report = _reportController.text;
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    content: Text('Report Submitted'),

                                    // add an action to the dialog box to close the dialog box when clicked
                                    actions: [
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'Close',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))
                                    ],
                                  ));
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  const SizedBox(height: 16.0),
                ]))));
  }
}

class View extends StatelessWidget {
  PdfViewerController? _pdfViewerController;

  final url;
  View({this.url});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Report"),
        backgroundColor: Config.primaryColor,
      ),
      body: SfPdfViewer.network(
        url,
        controller: _pdfViewerController,
      ),
    );
  }
}
