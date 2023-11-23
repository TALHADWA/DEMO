import 'dart:convert';

import 'package:demo/BaseHelper.dart';
import 'package:demo/favourite.dart';
import 'package:demo/model.dart';
import 'package:demo/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProviderScope(child: Home()));
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  void initState() {
    _loadData();

    super.initState();
  }

  _loadData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      BaseHelper.data.add(
         sharedPreferences.getStringList("title")
          );
    });
    navigate();
  }

  navigate() {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: ((context) => Ass())));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Ass extends ConsumerWidget {
  const Ass({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Obtain shared preferences.

    final AsyncValue<Welcome> das = ref.watch(future);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: ((context) => Favouritepage())));
            },
            icon: Icon(Icons.favorite)),
      ),
      body: das.when(data: ((data) {
        return ListView.builder(
            itemCount: data.results?.length,
            itemBuilder: ((context, index) {
              return Container(
                // color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListTile(
                  title: Text(data.results![index].title.toString()),
                  subtitle: Text(data.results![index].popularity.toString()),
                  leading: IconButton(
                      onPressed: () async {
                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        Local lc = Local(
                            leading: data.results![index].originalTitle,
                            title: data.results![index].title.toString());

                        prefs.setStringList("title", [lc.toString()]);
                        List<String>? titleList = prefs.getStringList("title");
                      

                        //  
                      },
                      icon: Icon(Icons.favorite)),
                ),
              );
            }));
      }), error: ((error, stackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      }), loading: (() {
        return Center(child: CircularProgressIndicator());
      })),
    );
  }
}
