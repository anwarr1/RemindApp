import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddUser extends StatefulWidget {
  AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  var nameController;
  var PhoneController;
  var EmailController;
  var CalendarController;
  // var textd;
  var datetime;
  @override
  void initState() {
    super.initState();
    print('Im here initstate');
    nameController = TextEditingController();
    PhoneController = TextEditingController();
    EmailController = TextEditingController();
    CalendarController = TextEditingController();
    datetime = "Choisissez une date";
  }

  @override
  void dispose() {
    nameController.dispose();
    PhoneController.dispose();
    EmailController.dispose();
    CalendarController.dispose();
    print("callitiniaa");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Im here Build');
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Navbar(height, context),
              SizedBox(
                height: height * 0.07,
              ),
              Container(
                child: const Text(
                  "Ajoutez votre client ",
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TxtField(
                nameController,
                width,
                "Nom complet",
                Icon(Icons.account_circle_outlined),
              ),
              TxtField(
                PhoneController,
                width,
                "Numero telephone",
                Icon(Icons.phone_enabled),
              ),
              TxtField(
                EmailController,
                width,
                "Email (optional)",
                Icon(Icons.mail),
              ),
              GestureDetector(
                onTap: () {
                  showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025))
                      .then((value) {
                    setState(() {
                      datetime = value.toString();
                    });
                  });
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: width * 0.9,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        // color: Colors.redAccent,
                        color: Color.fromARGB(255, 241, 241, 241),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(width: width * 0.009),
                        Text(
                          datetime.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            letterSpacing: 1.3,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection("clients").add({
                      'name': nameController.value.text,
                      "phone": PhoneController.value.text,
                      "email": EmailController.value.text
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(300, 40),
                    primary: Color.fromARGB(255, 41, 32, 118),
                  ),
                  child: Text('Ajouter'))
            ],
          ),
        ),
      )),
    );
  }
}

Widget TxtField(
  TextEditingController control,
  // String? field,
  double width,
  String hint,
  Icon iconn,
) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      width: width * 0.9,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          // color: Colors.redAccent,
          color: Color.fromARGB(255, 241, 241, 241),
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        children: [
          iconn,
          SizedBox(width: width * 0.009),
          Container(
            width: width * 0.5,
            child: hint == "Numero telephone"
                ? TextFormField(
                    // enabled: read,
                    keyboardType: TextInputType.phone,
                    // readOnly: read,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 1.3,
                        )),
                    controller: control,
                  )
                : TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Veuillez remplir ce champ";
                      }
                    },
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          letterSpacing: 1.3,
                        )),
                    controller: control,
                  ),
          ),
        ],
      ),
    ),
  );
}

Widget Navbar(double height, BuildContext context) {
  return Container(
    width: double.infinity,
    height: height * 0.15,
    decoration: const BoxDecoration(
        color: Color.fromARGB(255, 41, 32, 118),
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30))),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back_sharp,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    ),
  );
}
