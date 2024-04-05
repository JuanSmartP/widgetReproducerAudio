import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

final audioplayers = AudioPlayer();
bool isPlaying = false;
Duration duration = Duration.zero;
Duration position = Duration.zero;

class CustomReproducer extends StatefulWidget {
  const CustomReproducer({super.key});

  @override
  State<CustomReproducer> createState() => _CustomReproducerState();
}

class _CustomReproducerState extends State<CustomReproducer> {
  @override
  void initState() {
    audioplayers.onPlayerStateChanged.listen((event) {
      isPlaying = event == PlayerState.playing;
    });

    audioplayers.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioplayers.onPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String formatTime(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final hours = twoDigits(duration.inHours);
      final minutes = twoDigits(duration.inMinutes.remainder(60));
      final seconds = twoDigits(duration.inSeconds.remainder(60));

      return [
        if (duration.inHours > 0) hours,
        minutes,
        seconds,
      ].join(':');
    }

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 90),
          child: Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await audioplayers.seek(position);
              await audioplayers.resume();
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 110),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(formatTime(position)), Text(formatTime(duration))],
          ),
        ),
        const CustomButton(
          icon: Icons.play_arrow,
        )
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  const CustomButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35,
      child: IconButton(
        icon: Icon(isPlaying ? Icons.pause_sharp : Icons.play_arrow_sharp),
        iconSize: 50,
        onPressed: () async {
          if (isPlaying) {
            await audioplayers.pause();
          } else {
            Source url = UrlSource(
              'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
            );
            await audioplayers.play(url);
          }
        },
      ),
    );
  }
}


//'https://www.bibloplus.com/~biblop/webservice/EndSubir/Grabaciones/2024AprThu22Aprth660f29823abae.wav'
//https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3