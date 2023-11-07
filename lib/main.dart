import 'dart:isolate';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/boing__bounce.gif"),
            ElevatedButton(onPressed: () async{
             await heavyLongTimeTask();
            }, child: const Text("Task 1")),
            ElevatedButton(onPressed: () async{
              final receivePort = ReceivePort();
              await Isolate.spawn(complexTask2, receivePort.sendPort);
              receivePort.listen((total) {
                debugPrint('Result 2: $total');
              });
            }, child: const Text("Task 2")),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<int>heavyLongTimeTask()async{
    int x =0;
    for(int i=0; i<=100000000;i++){
      x +=i;
    }
    print(x);
    return x;
  }
  complexTask(SendPort sendPort){
    int x =0;
    for(int i=0; i<=100000000;i++){
      x +=i;
    }
    print(x);
   sendPort.send(x);
  }
}
complexTask2(SendPort sendPort) {
  var total = 0.0;
  for (var i = 0; i < 1000000000; i++) {
    total += i;
  }
  sendPort.send(total);
}


