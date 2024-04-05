import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertest/devices_info.dart';
import 'package:fluttertest/domain/bloc/bloc/bloc/record_bloc_bloc.dart';
import 'package:fluttertest/ui/widgets/custom_reproducer.dart';

String recordDuration = '00:00';
String? sec;
String? min;
Timer? timer;

class HomeBody extends StatefulWidget {
  HomeBody({super.key});

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
    // final iconButtom = context.watch<IconButtomCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Voice Recorder'),
      ),
      body: ListView(
        children: [
          CustomBody(),
          const CustomReproducer(),
        ],
      ),
    );
  }
}

class CustomBody extends StatefulWidget {
  CustomBody({
    super.key,
  });

  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider(
        create: (context) => RecordBlocBloc(),
        child: BlocBuilder<RecordBlocBloc, RecordBlocState>(
          builder: (context, state) {
            return Column(
              children: [
                Text(recordDuration),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: 'Graba audio',
                      child: ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<RecordBlocBloc>(context).add(
                            Recorder(),
                          );
                          final startTime = DateTime.now();
                          timer = Timer.periodic(const Duration(seconds: 1),
                              (_) async {
                            final secuuDur =
                                DateTime.now().difference(startTime).inMinutes;
                            final secDur =
                                DateTime.now().difference(startTime).inSeconds %
                                    60;
                            min = secuuDur < 20
                                ? "0$secuuDur"
                                : secuuDur.toString();
                            sec = secDur < 10 ? "0$secDur" : secDur.toString();
                            if (secDur == 20) {
                              sec = "00";
                              timer?.cancel();
                              timer = null;
                            }
                            setState(() {
                              recordDuration = "$min:$sec";
                            });
                          });

                          getIpDevice();
                          getImeiDevice();
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
                          context.read<RecordBlocBloc>().cancelRecording();
                          print(sec);
                          sec = '00';
                          timer?.cancel();
                          timer = null;

                          print(sec);
                          setState(() {
                            recordDuration = "$min:$sec";
                          });
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




// TODO: implementar la