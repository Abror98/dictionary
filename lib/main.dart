import 'package:dictionary/bloc/bloc.dart';
import 'package:dictionary/model/model_dic.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyHomePage());
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();
  bool en = true;

  @override
  initState() {
    super.initState();
    bloc.getWord(en);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(221, 221, 221, 1),
          title: TextField(
            controller: editingController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                size: 24,
                color: Colors.red,
              ),
              border: InputBorder.none,
              hintText: "Search-Qidiruv",
              hintStyle: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.wifi,
                color: Colors.red,
              ),
              tooltip: 'Setting Icon',
              onPressed: () {
                if (en == true) {
                  en = false;
                  bloc.getWord(en);
                } else {
                  en = true;
                  bloc.getWord(en);
                }
              },
            ),
          ],
        ),
        body: StreamBuilder<List<Dictionary>>(
            stream: bloc.allUser,
            builder: (context, AsyncSnapshot<List<Dictionary>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctxt, int Index) {
                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: en
                              ? _buildRowEN(snapshot.data[Index])
                              : _buildRowUZ(snapshot.data[Index]),
                        ),
                        Divider()
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("error"),
                );
              }
              return Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 50.0,
                  width: 50.0,
                ),
              );
            }),
      ),
    );
  }

  Widget _buildRowEN(Dictionary dic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            dic.en,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            bloc.speak(dic.en);
          },
          child: Icon(
            Icons.volume_down,
            color: Colors.red,
            size: 32,
          ),
        ),
      ],
    );
  }

  Widget _buildRowUZ(Dictionary dic) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            dic.uz,
            style: TextStyle(
              fontSize: 14,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
