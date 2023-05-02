import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:hospital_app/screens/doctor/doctorreport.dart';
class Homepag2 extends StatefulWidget {
  const Homepag2({super.key});

  @override
  State<Homepag2> createState() => _Homepag2State();
}

class _Homepag2State extends State<Homepag2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[Home(), HomeAppoint(), Todo(), Homehealth()],
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
            'Welcome,\nDr. Smith',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
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

class HomeAppoint extends StatefulWidget {
  const HomeAppoint({
    super.key,
  });

  @override
  State<HomeAppoint> createState() => _HomeAppointState();
}

class _HomeAppointState extends State<HomeAppoint> {
  List<bool> _selected = [false, false, false];

  @override
  Widget build(BuildContext context) {
    final List<String> docname = <String>[
      "Hilda Douka",
      'Brenda Kukah',
      'Peter Pan'
    ];
    final List<String> doctype = <String>['Dental', 'Dental', 'Opthamology'];
    final List<String> doctime = <String>['13:30', '11:00', '4:00'];
    final List<String> docavatar = <String>[
      'assets/hilda.png',
      'assets/person1.jpg',
      'assets/person2.jpg'
    ];

    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Today's Patients",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 14, color: Color(0xFF0E0255)),
          ),
          SizedBox(
              height: 120,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: docname.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            _selected[index] = !_selected[index];
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorReportScreen(),
                            ),
                          );
                          ;
                        },
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: _selected[index] ? 0.8 : 1.0,
                          child: Container(
                            width: 260,
                            margin: EdgeInsets.all(10),
                            child: Material(
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), //
                                ),
                                leading: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('${docavatar[index]}'),
                                ),
                                title: Text(
                                  "${docname[index]}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                subtitle: Text(
                                  "${doctype[index]}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                visualDensity:
                                    VisualDensity(horizontal: 0, vertical: 4),
                                trailing: Text("${doctime[index]}",
                                    style: TextStyle(
                                        color: Color(0xFFC12604),
                                        backgroundColor: Colors.white,
                                        fontWeight: FontWeight.w500)),
                                tileColor: Color(0xFF0E0255),
                              ),
                            ),
                          ),
                        ),
                      )))
        ])));
  }
}

class Todo extends StatefulWidget {
  @override
  _TodoState createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<Map<String, dynamic>> todos = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Upcoming Tasks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color(0xFF0E0255),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String newTodo = '';
                        return AlertDialog(
                          title: Text('Add Todo'),
                          content: TextField(
                            autofocus: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter your todo',
                            ),
                            onChanged: (value) {
                              newTodo = value;
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  todos.add({
                                    'title': newTodo,
                                    'isChecked': false,
                                  });
                                });
                                Navigator.pop(context);
                              },
                              child: Text('Add'),
                            ),
                          ],
                        );
                      });
                },
                child: Icon(
                  Icons.add,
                  color: Color(0xFF0E0255),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.transparent),
                  elevation: MaterialStateProperty.all<double>(0),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: todos[index]['isChecked']
                          ? Color.fromRGBO(193, 38, 4, 0.3)
                          : Color.fromRGBO(193, 38, 4, 0.3),
                    ),
                    child: ListTile(
                      title: Text(
                        todos[index]['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0E0255),
                        ),
                      ),
                      leading: Checkbox(
                        onChanged: (bool? value) {
                          setState(() {
                            // Update the state of the todo item when the checkbox is toggled
                            todos[index]['isChecked'] = value!;
                          });
                        },
                        value: todos[index]['isChecked'],
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Color.fromRGBO(193, 38, 4, 0.3)),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            todos.removeAt(index);
                          });
                        },
                        color: Color.fromRGBO(193, 38, 2, 0.3),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Homehealth extends StatelessWidget {
  const Homehealth({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> tipstitle = <String>[
      'Food For a Healthy Heart',
      'What is Mental Health',
      'Understand Blood Type'
    ];
    final List<String> tipspara = <String>[
      'Eating a healthy diet is one of the most important steps you can take to maintain a healthy heart. Your heart requires the right nutrients and energy to function optimally, and a healthy diet can help reduce your risk of heart disease, stroke, and other cardiovascular problems...',
      'Mental health refers to a person overall emotional, psychological, and social well-being. It encompasses a range of factors that influence an individual thoughts, feelings, and behavior, and it can be impacted by a range of biological, environmental...',
      'Understanding your blood type is important for several reasons. Blood type is determined by the presence or absence of certain antigens on the surface of red blood cells. There are four main blood types: A, B, AB, and O.The ABO blood system is the most important blood type...'
    ];
    final List<String> doctime = <String>['13:30', '11:00', '4:00'];
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Daily Health Tips",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 14, color: Color(0xFF0E0255)),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tipstitle.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => Container(
                        height: 300,
                        width: 150,
                        margin: EdgeInsets.all(10),
                        child: Card(
                          color: Color(0xFFC19804),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  Image(
                                    image: AssetImage("assets/health1.png"),
                                    height: 110,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(16).copyWith(bottom: 0),
                                child: Column(children: [
                                  Text(
                                    "${tipstitle[index]}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${tipspara[index]}",
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  )
                                ]),
                              ),
                              TextButton(
                                child: Text(
                                  "Read More",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 11),
                                ),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      )))
        ])));
  }
}
