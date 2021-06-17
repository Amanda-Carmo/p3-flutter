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
  final firstNotifier = ValueNotifier<bool>(true);
  final lastNotifier = ValueNotifier<bool>(true);

  // Funcionalidade para playlist
  final playlistNotifier = ValueNotifier<List<String>>([]);
  final songTitleNotifier = ValueNotifier<String>('');

  // Usando as músicas listadas em: https://www.soundhelix.com/audio-examples

  // static const url =
  //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';

  late AudioPlayer _audioPlayer;
  late ConcatenatingAudioSource _playlist;

  PageManager() {
    _init();
  }

  void _listenForChangesInPlayerState() {
    _audioPlayer.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading ||
          processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer.seek(Duration.zero);
        _audioPlayer.pause();
      }
    });
  }

  void _init() async {
    // Inicia o player
    _audioPlayer = AudioPlayer();
    _listenForChangesInPlayerState();

    final song1 = Uri.parse(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
    final song2 = Uri.parse(
        "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3");
    final song3 = Uri.parse(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3');
    final song4 = Uri.parse(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3');

    _playlist = ConcatenatingAudioSource(children: [
      AudioSource.uri(song1, tag: 'Música 1'),
      AudioSource.uri(song2, tag: 'Música 2'),
      AudioSource.uri(song3, tag: 'Música 3'),
      AudioSource.uri(song4, tag: 'Música 4'),
    ]);

    // await _audioPlayer.setUrl(url);
    await _audioPlayer.setAudioSource(_playlist);

    // // Atualiza o botão de play para pause e mostra barra de progresso quando o
    // // áudio está carregando, não está pronto para reprodução.

    // _audioPlayer.playerStateStream.listen((playerState) {
    //   final isPlaying = playerState.playing;
    //   // processingState: pacote do Just Audio - estado do áudio

    //   final processingState = playerState.processingState;
    //   if (processingState == ProcessingState.loading ||
    //       processingState == ProcessingState.buffering) {
    //     // Caso o áudio ainda não esteja pronto, o botão abaixo da barra de
    //     // reprodução mostrará o indicador circular de progresso.
    //     buttonNotifier.value = ButtonState.loading;

    //     // Volta para posição inicial ao terminar a música
    //   } else if (processingState != ProcessingState.completed) {
    //     buttonNotifier.value = ButtonState.playing;
    //   } else {
    //     // completed
    //     _audioPlayer.seek(Duration.zero);
    //     _audioPlayer.pause();
    //   }
    // });

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
    _audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState == null) return;

      // Msc atual
      final thisItem = sequenceState.currentSource;
      final title = thisItem?.tag as String?;
      songTitleNotifier.value = title ?? '';

      // playlist
      final playlist = sequenceState.effectiveSequence;
      final titles = playlist.map((item) => item.tag as String).toList();
      playlistNotifier.value = titles;

      // update previous and next buttons
      if (playlist.isEmpty || thisItem == null) {
        firstNotifier.value = true;
        lastNotifier.value = true;
      } else {
        firstNotifier.value = playlist.first == thisItem;
        lastNotifier.value = playlist.last == thisItem;
      }
    });
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

  void onPreviousSongButtonPressed() {
    _audioPlayer.seekToPrevious();
  }

  void onNextSongButtonPressed() {
    _audioPlayer.seekToNext();
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
