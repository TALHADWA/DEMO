import 'package:demo/BaseHelper.dart';
import 'package:demo/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Favouritepage extends ConsumerWidget {
  const Favouritepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ListView.builder(
          itemCount: BaseHelper.data.length,
          itemBuilder: ((context, index) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListTile(
                title: Text(BaseHelper.data[index].title.toString()),
                subtitle: Text(BaseHelper.data[index].subtitle.toString()),
                leading: Text(BaseHelper.data[index].leading.toString()),
              ),
            );
          })),
    );
  }
}
