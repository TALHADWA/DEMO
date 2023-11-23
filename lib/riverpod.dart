import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'package:demo/model.dart';

class Api {
  Future<Welcome> getdata() async {
    final da = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/discover/movie/?api_key=3afb2a42770e3a2e65fc4714027b5453"));
    var ass = jsonDecode(da.body);
    Welcome axc = Welcome.fromJson(ass);
    return axc;
  }
}

final classProvider = Provider(((ref) {
  return Api();
}));

final future = FutureProvider<Welcome>(((ref) {
  final asdc = ref.watch(classProvider);
  return asdc.getdata();
}));

class Add {
  String? title;
  String? subtitle;
  String? leading;
  Add({this.title, this.subtitle, this.leading});
}

class Addtofavorite extends StateNotifier<List<Add>> {
  Addtofavorite() : super([]);
  void add(Add item) {
    state= [...state, item,];
  }
}



final dataProvider = StateNotifierProvider<Addtofavorite, List<Add>>((ref) => Addtofavorite());
