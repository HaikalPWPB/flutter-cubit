import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_cubit/cubit/counter_cubit.dart';
import 'package:learn_cubit/cubit/post_cubit.dart';

class AnotherScreen extends StatelessWidget {
  const AnotherScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(context.read<CounterCubit>().state.toString()),
    );
  }
}