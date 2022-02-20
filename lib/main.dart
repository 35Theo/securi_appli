import 'package:flutter/material.dart';
import 'package:securi_appli/crud.dart';
import 'package:securi_appli/request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<Equipments> futureEquipment;
  @override
  Widget build(BuildContext context) {
    futureEquipment = fetchEquipments();
    return Scaffold(
      backgroundColor: const Color.fromRGBO(55, 158, 193, 1),
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'GO Securi',
          style: TextStyle(
            color: Color.fromRGBO(0, 89, 34, 1),
            fontWeight: FontWeight.bold,
            // fontFamily: 'Roboto',
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: EdgeInsets.all(20),
                  child: FutureBuilder<Equipments>(
                    future: futureEquipment,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.nameEquipment);
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }

                      // By default, show a loading spinner.
                      return const CircularProgressIndicator();
                    },
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            _addStuffDialog(context),
                      );
                    },
                    child: const Text(
                      'Ajouter un équipement',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final nouvelEquipment = TextEditingController();
Widget _addStuffDialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    title: const Text('Ajouter un équipement'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: const InputDecoration(
            hintText: "Equipement",
          ),
          controller: nouvelEquipment,
        ),
      ],
    ),
    actions: <Widget>[
      // Bouton UPDATE Datas from liste.txt
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextButton(
              onPressed: () {
                var newEquipment = nouvelEquipment.value.text;
                RequestGit().addMaterialToList(
                    "mousqueton    Mousqueton \n gants    Gants d intervention \n brassard    Brassard de securite \n menottes    Porte menottes \n cyno    Bandeau agent cynophile \n talky    Talkies walkies \n lampe   Lampe Torche \n kit    Kit oreillette \n taser    Tasers \n lacrymo    Bombes lacrymogenes \n falshb Flash Ball ",
                    newEquipment);
                Navigator.of(context).pop();
              },
              child: const Text(
                'Ajouter',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.backspace,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    ],
  );
}
