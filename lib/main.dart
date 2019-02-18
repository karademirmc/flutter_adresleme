import 'package:flutter/material.dart';
import 'package:flutter_adresleme/models/adres.dart';
import 'package:flutter_adresleme/utils/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  DatabaseHelper _databaseHelper;
  List<Adres> tumAdresler;
  String kod = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _databaseHelper = DatabaseHelper();
    tumAdresler = List<Adres>();

    _listeYenile(); // tüm ülkeleri getir
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _listViewGetir(context),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            tumAdresler.clear();
            if(kod.length>=4)
              {
                kod = kod.substring(0, kod.length - 4);
                kod += "__";
              }

            _listeYenile();
          },
          child: Icon(Icons.arrow_back)),
    );
  }

  _listViewGetir(BuildContext context) {
    return tumAdresler.length <= 0
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: tumAdresler.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(tumAdresler[index].lokasyonunAdi),
                onTap: () {
                  kod = tumAdresler[index].idKod + "__";
                  _listeYenile();
                },
              );
            });
  }

  _listeYenile() async {
    if (kod == "") kod = "__";
    await _databaseHelper.sqlCalistir(kod).then((gelenAdresler) {
      tumAdresler = gelenAdresler;
      setState(() {});
      print("kod :" +kod);
    });
  }
}
