// ignore_for_file: prefer_const_declarations, dead_code

import 'package:audio_player/network_sound_player.dart';
import 'package:audio_player/sound_player.dart';
import 'package:audio_player/sound_recorder.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final recorder = SoundRecorder();
  final player = SoundPlayer();
  final networkPlayer = NetworkSoundPlayer();

  @override
  void initState() {
    super.initState();
    recorder.init();
    player.init();
    networkPlayer.init();
  }

  @override
  void dispose() {
    super.dispose();
    recorder.dispose();
    player.dispose();
    networkPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text("Audio Player")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildStart(),
              const SizedBox(
                height: 30,
              ),
              buildPlay(),
              const SizedBox(
                height: 30,
              ),
              buildNetworkPlay()
            ],
          ),
        ));
  }

  Widget buildStart() {
    final isRecording = recorder.isRecording;
    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'Stop' : 'Start';
    final onPrimary = isRecording ? Colors.white : Colors.black;
    final primary = isRecording ? Colors.red : Colors.white;

    return ElevatedButton.icon(
        onPressed: () async {
          final isRecording = await recorder.toggleRecording();
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(175, 50),
          onPrimary: onPrimary,
          primary: primary,
        ),
        icon: Icon(icon),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }

  Widget buildPlay() {
    bool isPlaying = player.isPlaying;
    final icon = isPlaying ? Icons.pause : Icons.play_circle;
    final text = isPlaying ? 'Stop recording' : 'Play recording';

    return ElevatedButton.icon(
        onPressed: () async {
          await player.togglePlayer(() => setState(() {}));
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(175, 50),
          onPrimary: Colors.black,
          primary: Colors.white,
        ),
        icon: Icon(icon),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }

  Widget buildNetworkPlay() {
    bool isPlaying = networkPlayer.isPlaying;
    final icon = isPlaying ? Icons.pause : Icons.play_circle;
    final text = isPlaying ? 'Stop network audio' : 'Play Network audio';

    return ElevatedButton.icon(
        onPressed: () async {
          await networkPlayer.togglePlayer(() => setState(() {}));
          setState(() {});
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(175, 50),
          onPrimary: Colors.black,
          primary: Colors.white,
        ),
        icon: Icon(icon),
        label: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }
}
