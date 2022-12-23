import 'package:VisitsApp/addUser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter  YouTube UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.blueAccent),
      ),
      // home: FavScreen(),

      home: HomePage(), darkTheme: ThemeData(brightness: Brightness.dark),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('clients').snapshots();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    fullscreenDialog: true, builder: (_) => AddUser()));
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          fullscreenDialog: true, builder: (_) => AddUser()));
                },
                icon: Icon(Icons.add))),
        body: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot doc = snapshot.data!.docs[index];
                return Client(doc["name"], doc["email"], doc["phone"]);
              },
            );
          },
        ));
  }
}

Widget Client(String name, String mail, String phone) {
  return Container(
    margin: EdgeInsets.all(7),
    decoration: BoxDecoration(
        color: Colors.grey[200], borderRadius: BorderRadius.circular(5)),
    child: ListTile(
        title: Text(name), subtitle: Text(mail), trailing: Text(phone)),
  );
}
