import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/cubit/post_cubit.dart';
import 'package:new_project/di/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  runApp(BlocProvider(
    create: (context) => di<PostCubit>(),
    child: MaterialApp(
      home: MyApp(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostCubit>(context).downloadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Dependency Injection"),
        ),
        body: BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostInitial) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PostLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is PostSuccess) {
              return ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.blue,
                  child: Center(
                    child: Text(state.list[index].title ?? "empty"),
                  ),
                );
              });
            } else if (state is PostError) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      onPressed: () {
                        BlocProvider.of<PostCubit>(context).downloadPosts();
                      },
                      color: Colors.blue,
                      child: Text(
                        "Qayta yuklash",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          },
        ));
  }
}
