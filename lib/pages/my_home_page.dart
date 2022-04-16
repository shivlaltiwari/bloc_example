import 'package:flutter/material.dart';
import 'package:template/model/dog_image_model.dart';
import 'package:template/viewmodel/dog_bloc.dart';

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CounterBloc counterBloc = CounterBloc();

  @override
  void initState() {
    counterBloc.eventSink.add(OperationType.fetch);
    super.initState();
  }

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc design"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          counterBloc.eventSink.add(OperationType.fetch);
        },
        child: ListView(
          shrinkWrap: true,

          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder<DogImageModel>(
                      stream: counterBloc.imageStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Align(
                              alignment: Alignment.center,
                              child:
                                  Image.network('${snapshot.data!.message}'));
                        } else if (snapshot.hasError) {
                          return Align(
                              alignment: Alignment.center,
                              child: Text("Somthing is went worng"));
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      })
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
