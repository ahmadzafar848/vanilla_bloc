import 'package:flutter/material.dart';

import '../bloc/counter_bloc.dart';
import '../bloc/counter_event.dart';
import '../bloc/counter_state.dart';

class HomePage extends StatelessWidget {
  CounterBloc counterBloc = CounterBloc();
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc'),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Pre the button'),
            StreamBuilder<CounterState>(
              stream: counterBloc.counterStateStream,
              initialData: CounterState(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    snapshot.connectionState == ConnectionState.none) {
                  return Text('Waiting');
                } else if (snapshot.connectionState == ConnectionState.active ||
                    snapshot.connectionState == ConnectionState.done) {
                  return Text('${snapshot.data!.counter}');
                } else {
                  return Text('Error');
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.counterEventSink.add(IncrementCounter());
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              counterBloc.counterEventSink.add(DecrementCounter());
            },
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
