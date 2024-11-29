import 'package:flutter/material.dart';
import '../models/music.dart';

class MusicCard extends StatelessWidget {
  final Music music;
  final Function(String musicPath) onPlay;

  const MusicCard({
    Key? key,
    required this.music,
    required this.onPlay,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: ListTile(
        title: Text(
          music.title,
          style: const TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          music.description,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.play_arrow, color: Colors.white),
          onPressed: () {
            onPlay(music.musicPath);
          },
        ),
      ),
    );
  }
}
