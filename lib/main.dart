import 'package:dictionary/bloc/bloc.dart';
import 'package:dictionary/db/sqlite_helper.dart';
import 'package:dictionary/model/model_dic.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Dictionary'),
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
  @override
  initState(){
    super.initState();
    event();
  }
  event() async {
     bloc.getWords();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<Dictionary>>(
         stream: bloc.allUserPed,
         builder: (context, AsyncSnapshot<List<Dictionary>> snapshot){
           if(snapshot.hasData){
             ListView.builder(
                 itemCount: snapshot.data.length,
                 itemBuilder:(BuildContext ctxt, int Index) {
                   return _buildRow(snapshot.data[Index]);
                 }
             );
           }
           else if(snapshot.hasError){
             return Center(child: Text("error"));
           }
           return Center(
             child: SizedBox(
               child: CircularProgressIndicator(),
               height: 50.0,
               width: 50.0,
             ),
           );
         }

       ),
      
    );
  }
Widget _buildRow(Dictionary dic) {
  return Text(dic.en);
}

}


