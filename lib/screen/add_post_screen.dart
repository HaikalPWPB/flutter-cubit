import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_cubit/cubit/counter_cubit.dart';
import 'package:learn_cubit/cubit/post_cubit.dart';
import 'package:learn_cubit/main.dart';
import 'package:learn_cubit/model/post_model.dart';
import 'package:learn_cubit/screen/another_screen.dart';

class AddPostScreen extends StatefulWidget {
  AddPostScreen({ Key? key }) : super(key: key);

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final _titleController = new TextEditingController();
  final _bodyController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title',
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: _bodyController,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Body',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                var data = {
                  'title': _titleController.text,
                  'body': _bodyController.text,
                  'userId': 1
                };

                var post = await context.read<PostCubit>().storePost(data);
                Navigator.pop(context);
              }, 
              child: Text('Submit')
            ),
          ],
        )
      ),
    );
  }
}