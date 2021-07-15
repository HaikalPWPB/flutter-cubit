import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_cubit/cubit/counter_cubit.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<String> items = List<String>.generate(10, (index) => "Item $index");
  List<String> _selectedProduct = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        if(_selectedProduct.length != 0) {
          return InkWell(
            child: ListTile(
              title: Text(items[index]),
            ),
            onTap: () {
              setState(() {
                _selectedProduct.add(items[index]);
              });
              context.read<CounterCubit>().increment();
            },
          );
        } 
        return InkWell(
          child: ListTile(
            title: Text(items[index]),
          ),
          onTap: () {
            setState(() {
              _selectedProduct.add(items[index]);
            });
            context.read<CounterCubit>().increment();
          },
        );
      },
    );
  }
}