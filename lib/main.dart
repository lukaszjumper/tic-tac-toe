import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'board.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "Nowy gracz"),
    );
  }
}

final nameController = TextEditingController();
final group = DropDown(const ['Blokująca', 'Wygrywająca', 'Kontrolna']);
final sexChoose = DropDown(const ['Chłopiec', 'Dziewczynka']);


class DropDown extends StatefulWidget {
  DropDown(this.dropList, {Key? key}) {
    dropdownValue = dropList[0];
  }

  List<String> dropList;

  late String dropdownValue;
  @override
  State<DropDown> createState() => _DropDownState();
}

// Dropdown menu to choose 'group'.
class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: MediaQuery.of(context).size.width/3,
        child :DropdownButton<String>(
          value: widget.dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 100,
          style: const TextStyle(color: Colors.black, fontSize: 16),
          underline: Container(
            height: 1,
            color: Colors.grey,
          ),
          onChanged: (String? newValue) {
            setState(() {
              widget.dropdownValue = newValue!;
            });
          },
          items: widget.dropList
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        )
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();


}

class _MyHomePageState extends State<MyHomePage> {
  List<List<dynamic>> data = [];

  String buttonText = "GENERUJ WYNIKI";
  String buttonHint = "Zapisz wyniki z ostatnich rozgrywek w pliku csv";
  String interruptText = "WYJDŹ";
  int nr = -1;
  int playerId = 0;


  Game g = Game(2, true, [], "", "", "", 0, 0);


  bool isGameRunning = false;

  void startRound () {
    if (nameController.value.text == "") {
      showToast("Najpierw wpisz nazwę gracza!", context);
      return;
    }
    playerId++;
    buttonText = "DALEJ";
    buttonHint = "Ruch komputera lub zakończenie rundy";
    interruptText = "PRZERWIJ";
    g = Game(2, true, data, nameController.value.text, sexChoose.dropdownValue, group.dropdownValue, playerId, 0);

    isGameRunning = true;
    nr = 0;
    setState((){
      widget.title = titleString();
    });
    g.start();

    showToast("Zaczynasz!", context);

  }

  String titleString() {
    String player = ", nazwa gracza: " + nameController.value.text + ", grupa: " + group.dropdownValue;
    if (nr == -1) {
      return "Nowy gracz";
    }
    else if (nr == 0) {
      return "Runda testowa" + player;
    }
    else {
      return "Runda " + nr.toString() + "/16" + player;
    }
  }

  void interrupt() {
    if (isGameRunning) {
      setState(() {
        nr = -1;
        isGameRunning = false;
        widget.title = "Nowy gracz";
        buttonText = "GENERUJ WYNIKI";
        buttonHint = "Zapisz wyniki z ostatnich rozgrywek w pliku csv";
        interruptText = "WYJDŹ";
      });
    }
    else {
      // Exit app
      generateCsv();
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }

  Future<void> generateCsv() async {
    String csv = const ListToCsvConverter().convert(data);


    File f = File("wynik_eksperymentu.csv");
    f.writeAsString(csv);
  }

  void buttonAction() {
    if (nr >= 0 && (nr < 16 || (nr == 16 && !g.end()))) {
      if (g.end()) {
        nr++;
        g = Game(2- nr % 2, false, data, nameController.value.text, sexChoose.dropdownValue, group.dropdownValue, playerId, nr);
        setState(() {
          widget.title = titleString();
        });
        g.start();
        if (nr % 2 == 0) {
          showToast("Zaczynasz!", context);
        }
        else {
          showToast("Komputer zaczyna!", context);
        }
      }
      else {
        if (!g.computerMove()) {
          showToast("Teraz Twój ruch", context);
        }
      }
    }
    else {
      nr = -1;
      isGameRunning = false;
      widget.title = titleString();
      buttonText = "GENERUJ WYNIKI";
      buttonHint = "Zapisz wyniki z ostatnich rozgrywek w pliku csv";
      interruptText = "WYJDŹ";
      setState((){});
    }
    if(!isGameRunning) {
      generateCsv();
      showToast("Wygenerowano plik!", context);
    }
  }

  Widget gameBoard(Game g) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GameView(g),
            ],
          )
        ],
      ),
    );
  }

  final spaceControl = Stopwatch()..start();

  void _handleKeyEvent(RawKeyEvent event) {
      if (event.logicalKey == LogicalKeyboardKey.space && isGameRunning) {
        if (spaceControl.elapsed.inSeconds >= 1) {
          FocusScope.of(context).requestFocus(_buttonNode);
          buttonAction();
          spaceControl.reset();
        }
      }
  }

  // Name and sex of a player
  Widget form(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width/3,
              vertical: MediaQuery.of(context).size.height/10
          ),
          child: Column(
            children: [
              const Padding(
                child: Text("Nazwa gracza:"),
                padding: EdgeInsets.symmetric(vertical: 11),
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                ),
              ),
              const Padding(
                child: Text("Płeć gracza:"),
                padding: EdgeInsets.symmetric(vertical: 11),
              ),
              sexChoose,
              const Padding(
                child: Text("Grupa:"),
                padding: EdgeInsets.symmetric(vertical: 11),
              ),
              group,
              Padding(
                child: ElevatedButton(
                  onPressed: () {startRound();},
                  child: const SizedBox(
                    child: Center(
                        child: Text('Rozpocznij', style: TextStyle(fontSize: 20),)
                    ),
                    height: 40,
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                  ),
                ),
                padding: const EdgeInsets.symmetric(vertical: 20),
              )
            ],
          )
        )
      ],
    );
  }

  Widget currentView(BuildContext context) {
    if (!isGameRunning) {
      return form(context);
    }
    else {
      return gameBoard(g);
    }
  }

  final _focusNode = FocusNode();
  final _buttonNode = FocusNode();

  // Focus nodes need to be disposed.
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   if (isGameRunning && !g.end()) {
     FocusScope.of(context).requestFocus(_focusNode);
   }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RawKeyboardListener(
        child: currentView(context),
        onKey: _handleKeyEvent,
        focusNode: _focusNode,
      ),
      floatingActionButton: Column (
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: buttonAction,
            tooltip: buttonHint,
            focusNode: _buttonNode,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)
              ),  // is trailing comma makes auto-formatting nicer for build methods.
            ),
            label: Text(buttonText),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 5)
          ),
          FloatingActionButton.extended(
            heroTag: null,
            onPressed: interrupt,
            tooltip: 'Wyjście',
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0)
              ),  // is trailing comma makes auto-formatting nicer for build methods.
            ),
            label: Text(interruptText),
          )
        ],
      )

    );
  }
}

void showToast(String text, BuildContext context) {
  final scaffold = ScaffoldMessenger.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}