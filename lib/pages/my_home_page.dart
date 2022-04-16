import 'package:flutter/material.dart';
import 'package:template/viewmodel/counter_bloc.dart';

// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final CounterBloc counterBloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc design"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "counter :",
                style: TextStyle(fontSize: 20),
              ),
            ),
            StreamBuilder(
              stream: counterBloc.counterStream,
              builder: (context, snapshot) => Align(
                alignment: Alignment.center,
                child: Text(
                  '${snapshot.data}',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(OperationType.increment);
            },
            child: Text(
              "+",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(OperationType.decrement);
            },
            child: Text(
              "-",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
