import 'package:flutter/material.dart';
import 'package:learn_cubit/cubit/counter_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarComponent extends StatefulWidget {
  AppBarComponent({Key? key}) : super(key: key);

  @override
  AppBarComponentState createState() => AppBarComponentState();
}

class AppBarComponentState extends State<AppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text('Counter'),
        actions: [
          Stack(
            children: [
              Icon(Icons.shopping_cart),
              Positioned(
                top: 0,
                right: 0,
                child: Text(context.read<CounterCubit>().state.toString(), style:TextStyle(color: Colors.white)),
              )
            ],
          )
        ],
      );
  }
}