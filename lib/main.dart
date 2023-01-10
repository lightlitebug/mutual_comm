import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/color/color_bloc.dart';
import 'blocs/color_counter/color_counter_bloc.dart';
import 'blocs/counter/counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ColorBloc>(
          create: (context) => ColorBloc(),
        ),
        BlocProvider<CounterBloc>(
          create: (context) => CounterBloc(),
        ),
        BlocProvider<ColorCounterBloc>(
          create: (context) {
            final colorBloc = context.read<ColorBloc>();
            final counterBloc = context.read<CounterBloc>();

            return ColorCounterBloc(
              colorBloc: colorBloc,
              counterBloc: counterBloc,
            );
          },
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Mutual Comm',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorBloc>().state.color,
      appBar: AppBar(
        title: const Text('Mutual Comm'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${context.watch<CounterBloc>().state.counter}',
              style: const TextStyle(fontSize: 36),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<ColorBloc>().add(ToggleColorEvent());
                  },
                  child: const Text(
                    'Color',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<CounterBloc>()
                        .add(const IncrementCounterEvent(counter: 1));
                  },
                  child: const Text(
                    'Increment',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<CounterBloc>()
                        .add(const DecrementCounterEvent(counter: 2));
                  },
                  child: const Text(
                    'Decrement',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
