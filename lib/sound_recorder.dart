// ignore_for_file: unrelated_type_equality_checks

import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

final pathToSaveAudio = "audio_example.aac";

class SoundRecorder {
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;
  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final _status = Permission.microphone.request();
    print(_status.isGranted);
    await _audioRecorder!.openAudioSession();
    _isRecorderInitialised = true;
  }

  Future dispose() async {
    if (!_isRecorderInitialised) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future _record() async {
    if (!_isRecorderInitialised) return;

    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future _stop() async {
    if (!_isRecorderInitialised) return;

    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
