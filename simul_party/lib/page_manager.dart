import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';
import 'package:audio_session/audio_session.dart';
import 'dart:io';
import 'room.dart';

// Classe feita para isolar as funcionalidades player do front,
// como forma de melhor entendimento.

class PageManager {
  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);

  // Funcionalidade de pular para o prox e anterior
  // final nextNotifier = ;
  // final previousNotifier = ;

  // Usando as músicas listadas em: https://www.soundhelix.com/audio-examples

  // static const url =
  //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;

  PageManager() {
    _init();
  }
  void _init() async {
    _audioPlayer = AudioPlayer();

    final song1 = Uri.parse(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3');
    final song2 = Uri.parse(
        "https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3");
    final song3 = Uri.parse(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3');
    final song4 = Uri.parse(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3');

    _playlist = ConcatenatingAudioSource(children: [
      AudioSource.uri(song1,
          tag: AudioMetadata(
              album: 'Public Domain',
              title: 'Nature Sounds',
              artwork:
                  "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg")),
      AudioSource.uri(song2,
          tag: AudioMetadata(
              album: 'Science friday',
              title: 'A Salute To Head-Scratching Science (30 seconds)',
              artwork:
                  "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg")),
      AudioSource.uri(song3,
          tag: AudioMetadata(
              album: 'Sound helix',
              title: 'Song 3',
              artwork:
                  "https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg"))
    ]);

    // await _audioPlayer.setUrl(url);
    await _audioPlayer.setAudioSource(_playlist);

    // Atualiza o botão de play para pause e mostra barra de progresso quando o
    // áudio está carregando, não está pronto para reprodução.

    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      // processingState: pacote do Just Audio - estado do áudio

      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        // Caso o áudio ainda não esteja pronto, o botão abaixo da barra de
        // reprodução mostrará o indicador circular de progresso.
        buttonNotifier.value = ButtonState.loading;

        // Volta para posição inicial ao terminar a música
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        // completed
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });

    // Atualizando a barra de progresso:

    // Quando se clica na barra de progresso para avançar o som ou voltar para alguma parte,
    // É mostrado o estado de carregamento abaixo da barra.
    _audioPlayer.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        // A posição clicada será setada como atual
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    // Mostrando o que está no buffer
    _audioPlayer.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        // Progresso será conforme o que já estiver carregado.
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    _audioPlayer.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        // Pegando duração total
        total: totalDuration ?? Duration.zero,
      );
    });

    // Fazendo a playlist:
  }

  // Métodos para pausar um continuar a música (front --> onPressed)------------

  void play() {
    _audioPlayer.play();
  }

  void pause() {
    _audioPlayer.pause();
  }

// -----------------------------------------------------------------------------

  // Para pular a posição do progresso da música (voltar ou adiantar)
  void seek(Duration position) {
    _audioPlayer.seek(position);
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });

  // Estados da barra de música: atual, carregando (marca mais clara) e total (ao final da música)
  final Duration current;
  final Duration buffered;
  final Duration total;
}

// estados em que o botão aparecerá
enum ButtonState { paused, playing, loading }

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;

  AudioMetadata(
      {required this.album, required this.title, required this.artwork});
}