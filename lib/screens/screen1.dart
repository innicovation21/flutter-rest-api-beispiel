// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rest_api_beispiel/services/http_service.dart';
import 'package:sizer/sizer.dart';

import '../datamodels/post.dart';

import 'package:flutter/cupertino.dart';
import 'package:universal_io/io.dart' show Platform;

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  // Liste für die Posts von jsonplaceholder
  List<Post>? posts;
  // variable für ladestatus
  bool isLoaded = false;

  // Funktion zum befüllen von posts mit der antwort vom server
  Future<void> getData() async {
    // abrufen der Daten mittels Service
    posts = await HttpService().getPosts();

    // wenn der Inhalt von "posts" NICHT null ist
    if (posts != null) {
      // dann ändern wir den Wert von "isLoaded" in setState()
      // damit die buildMethod() erneut ausgeführt wird
      // und die Liste darstellen kann
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // bevor das widget fertig erstellt wird, starten wir die Future-Funktion "getData"
    getData();
    // ist also zum Zeitpunkt der Fertigstellung unseres Widgets, noch nicht geladen.
    // arbeitet die Funktion weiter im Hintergrund,
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REST API"),
        centerTitle: true,
      ),
      backgroundColor: Colors.teal,
      // "Visibility" ist ein Widget, welches zwei Möglichkeiten zur Darstellung bietet.
      body: Visibility(
        // welche davon angewandt wird, entscheided sich durch den Boolean in der Eigenschaft "visible"
        visible: isLoaded,
        // replacement ermöglicht eine Ansicht, sollte "visible" false sein
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        // ist "visible" true -> wird der Inhalt von Child dargestellt
        child: ListView.builder(
          // Anzahl der darzustellenden Elemente abhängig von posts?
          // ? - weil in der Deklarierung als nullable angegeben
          itemCount: posts?.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.all(2.h),
              // EdgeInsets.symmetric -> Seitenauswahl horizontal / vertikal
              margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              color: Colors.lightBlueAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // posts! <- das ! geben wir an, als Versprechen, dass der Wert NICHT null sein wird. (null-safety)
                  Text(posts![index].id.toString()),
                  Icon(
                    // dank des Packages universal_io, bei welchem wir uns die Platform anzeigen lassen können,
                    // auf welcher das Projekt ausgeführt wird, können wir die Auswahl des darzustellenden Icons,
                    // von der Plattform abhängig machen.
                    //.
                    // nachfolgender Syntax bedeutet:
                    // wenn die Platform iOS ist, dann das Apple-Design (cuptertinoicons) für den Button "delete" darstellen
                    // ansonsten aus dem material-design das entsprechende Equivalent von Android/Google
                    Platform.isIOS ? CupertinoIcons.delete : Icons.delete,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
