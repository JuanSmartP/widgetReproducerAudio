import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/devices_info.dart';
import 'package:fluttertest/domain/bloc/bloc/bloc/record_bloc_bloc.dart';
import 'package:fluttertest/domain/bloc/record_counter_bloc.dart';
import 'package:fluttertest/ui/widgets/custom_reproducer.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    recor;

    super.initState();
  }

  @override
  void dispose() {
    audioplayers.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Voice Recorder'),
      ),
      body: ListView(
        children: const [
          CustomBody(),
          CustomReproducer(),
        ],
      ),
    );
  }
}

class CustomBody extends StatefulWidget {
  const CustomBody({
    super.key,
  });

  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RecordBlocBloc(),
          ),
          BlocProvider(create: (context) => RecordCounterBloc(), lazy: false),
        ],
        child: BlocBuilder<RecordBlocBloc, RecordBlocState>(
          builder: (context, state) {
            return Column(
              children: [
                BlocBuilder<RecordCounterBloc, RecordCounterState>(
                  builder: (context, state) {
                    return Text(state.counterRecord);
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Graba audio',
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<RecordCounterBloc>(context)
                              .add(CounterInitial());
                          // BlocProvider.of<RecordBlocBloc>(context).add(
                          //   Recorder(),
                          // );

                          // if (!isRecording) {
                          //   final startTime = DateTime.now();
                          //   timer = Timer.periodic(const Duration(seconds: 1),
                          //       (_) async {
                          //     final secuuDur = DateTime.now()
                          //         .difference(startTime)
                          //         .inMinutes;
                          //     final secDur = DateTime.now()
                          //             .difference(startTime)
                          //             .inSeconds %
                          //         60;
                          //     min = secuuDur < 20
                          //         ? "0$secuuDur"
                          //         : secuuDur.toString();
                          //     sec =
                          //         secDur < 10 ? "0$secDur" : secDur.toString();
                          //     if (secDur == 20) {
                          //       sec = "00";
                          //       timer?.cancel();
                          //       timer = null;
                          //     }
                          //     // BlocProvider.of<RecordCounterBloc>(context)
                          //     //     .add(CounterInitial());

                          //     setState(() {
                          //       recordDuration = "$min:$sec";
                          //     });
                          //   });
                          // } else {
                          //   timer = null;
                          //   timer?.cancel();
                          //   sec = '00:00';
                          // }
                        },
                        child: const Icon(Icons.mic),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                      height: 100,
                    ),
                    Tooltip(
                      message: 'Cancela la grabacion',
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<RecordCounterBloc>().stopCunter();
                        },
                        child: const Text('Cancelar'),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
