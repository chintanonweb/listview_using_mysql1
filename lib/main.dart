import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> entries = <String>['A', 'B', 'C'];
  void initState() {
    getdb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: entries.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Center(child: Text('Entry ${entries[index]}')),
            );
          }),
    );
  }

  Future getdb() async {
    var settings = new ConnectionSettings(
        host: '192.168.0.100',
        port: 3306,
        user: 'shi',
        password: 'shi',
        db: 'test');
    var conn = await MySqlConnection.connect(settings);
    var results = await conn.query('select * from user');
    var list = results.toList();
    setState(() {
      for (var i = 0; i < list.length; i++) {
        entries.add(list[i]["name"].toString());
      }
    });
  }
}
