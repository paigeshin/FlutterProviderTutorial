import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountProvider extends ChangeNotifier {
  int _count = 0;
  int get count => _count;

  add() {
    _count++;
    notifyListeners();
  }

  remove() {
    _count--;
    notifyListeners();
  }
}

class PrintProvider extends ChangeNotifier {
  printMyAss() {
    print('print my ass');
  }

  printMyMiddleFinger() {
    print('Print my middle finger');
  }
}

void main() {
  runApp(MyApp());
  // runApp(
  //   ChangeNotifierProvider(
  //     create: (BuildContext context) => CountProvider(),
  //     child: MyApp(),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        /* Single Provider */
        create: (BuildContext context) => CountProvider(),
        child: Home(),
      ),
    );
  }
}

class Home extends StatelessWidget {
  late CountProvider _countProvider;
  @override
  Widget build(BuildContext context) {
    print('Build called!');
    _countProvider = Provider.of<CountProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Sample'),
      ),
      body: CountHomeWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              _countProvider.add();
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () {
              _countProvider.remove();
            },
            icon: Icon(Icons.remove),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ChangeNotifierProvider(
                        /* Single Provider */
                        create: (BuildContext context) => PrintProvider(),
                        child: SecondScreen(),
                      );
                      // return SecondScreen();
                    },
                  ),
                );
              },
              icon: Icon(
                Icons.golf_course,
              ))
        ],
      ),
    );
  }
}

class CountHomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<CountProvider>(
        builder: (context, provider, child) {
          return Text(
            provider.count.toString(),
            style: TextStyle(fontSize: 80),
          );
        },
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  late PrintProvider _printProvider;

  @override
  Widget build(BuildContext context) {
    print('Build called!');
    _printProvider = Provider.of<PrintProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Sample'),
      ),
      body: Center(
        child: Text("I'm a second screen you"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              _printProvider.printMyAss();
            },
            icon: Icon(Icons.ac_unit),
          ),
          IconButton(
            onPressed: () {
              _printProvider.printMyMiddleFinger();
            },
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
