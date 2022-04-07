import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/public/flutter_sound_player.dart';

final pathToReadAudio =
    'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3';

class NetworkSoundPlayer {
  FlutterSoundPlayer? _audioPlayer;
  bool get isPlaying => _audioPlayer!.isPlaying;

  Future init() async {
    _audioPlayer = FlutterSoundPlayer();
    await _audioPlayer!.openAudioSession();
  }

  Future dispose() async {
    await _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
  }

  Future _play(VoidCallback whenFinished) async {
    await _audioPlayer!
        .startPlayer(fromURI: pathToReadAudio, whenFinished: whenFinished);
  }

  Future _stop() async {
    await _audioPlayer!.stopPlayer();
  }

  Future togglePlayer(VoidCallback whenFinished) async {
    if (_audioPlayer!.isStopped) {
      await _play(whenFinished);
    } else {
      await _stop();
    }
  }
}
