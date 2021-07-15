import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_cubit/cubit/bottom_navigation_cubit.dart';
import 'package:learn_cubit/cubit/counter_cubit.dart';
import 'package:learn_cubit/cubit/post_cubit.dart';
import 'package:learn_cubit/model/post_model.dart';
import 'package:learn_cubit/resources/post_repository.dart';
import 'package:learn_cubit/screen/add_post_screen.dart';
import 'package:learn_cubit/screen/cart.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PostCubit>(create: (context) => PostCubit(repository: PostRepository())),
        BlocProvider<BottomNavigationCubit>(create: (context) => BottomNavigationCubit()),
        BlocProvider<CounterCubit>(create: (context) => CounterCubit())
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      )
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostPage();
  }
}

class PostPage extends StatefulWidget {
  const PostPage({ Key? key }) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}


class _PostPageState extends State<PostPage> {
  late Future<List<PostModel>?> futurePost;
  int _selectedIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futurePost = context.read<PostCubit>().getPosts();
    _selectedIndex = context.read<BottomNavigationCubit>().index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          Stack(
            children: [
              Icon(Icons.shopping_cart),
              Positioned(
                top: 0,
                right: 0,
                child: BlocBuilder<CounterCubit, int>(
                  builder: (context, state) {
                    return Text(state.toString());
                  }
                )
              )
            ],
          )
        ],
      ),
      body: _selectedBody(context),
      floatingActionButton: FloatingActionButton(
        child: Text('Add News'),
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => AddPostScreen())
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) {
          setState(() {
            context.read<BottomNavigationCubit>().selectIndex(value);
            _selectedIndex = context.read<BottomNavigationCubit>().index;
          });
          print(context.read<BottomNavigationCubit>().index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'user')
        ],
      ),
    );
  }

  Widget _postList(state) {
    return ListView.builder(
      itemCount: state.length,
      itemBuilder: (context, index) {
        PostModel post = state[index];
        return ListTile(
          title: Text(post.title),
          leading: Text(post.id.toString()),
        );
      },
    );
  }

  _selectedBody(context) {
    switch(_selectedIndex) {
      case 0:
        return BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if(state is PostError) {
              return Text('Error');
            }
            if(state is PostListLoaded) {
              return _postList(state.posts);
            }
          return LinearProgressIndicator();
          }
        );
      case 1:
        return Cart();
    }
  }
}