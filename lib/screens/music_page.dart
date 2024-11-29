import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
import '../models/music.dart';
import '../widgets/music_card.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key}) : super(key: key);

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> with TickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentMusicPath = '';
  late AnimationController _controller;
  late Animation<double> _animation;

  // Fungsi untuk memutar musik
  Future<bool> _validateAsset(String assetPath) async {
    try {
      await rootBundle.load(assetPath); // Memeriksa apakah asset tersedia
      return true;
    } catch (e) {
      print('Asset not found: $assetPath');
      return false;
    }
  }

  void _playMusic(String musicPath) async {
    if (!await _validateAsset(musicPath)) {
      _showErrorDialog('File musik tidak ditemukan: $musicPath');
      return;
    }

    try {
      await _audioPlayer.play(AssetSource(musicPath));
      setState(() {
        isPlaying = true;
        currentMusicPath = musicPath;
      });
    } catch (e) {
      print('Error playing music: $e');
      _showErrorDialog('Error playing music: $e');
    }
  }

  // Fungsi untuk menghentikan musik
  void _stopMusic() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
      currentMusicPath = '';
    });
  }

  // Fungsi untuk menjeda musik
  void _pauseMusic() async {
    await _audioPlayer.pause();
    setState(() {
      isPlaying = false;
    });
  }

  // Menampilkan dialog error
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    // Setup AnimationController dan Animation
    _controller = AnimationController(
      duration: const Duration(seconds: 10), // Durasi animasi
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan MediaQuery untuk menyesuaikan ukuran layar
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    List<Music> musicList = [
      Music(
        title: 'Seize The Day',
        description: 'Avenged Sevenfold.',
        musicPath: 'assets/music/Seize_the_day.mp3',
      ),
      Music(
        title: 'Helena',
        description: 'My Chemical Romance.',
        musicPath: 'assets/music/Helena.mp3',
      ),
      Music(
        title: 'Disenchanted',
        description: 'My Chemical Romance.',
        musicPath: 'assets/music/Disenchanted.mp3',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Daftar Musik',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.05),

            // Animasi teks berjalan menggunakan AnimationController
            isPlaying
                ? AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(
                          _animation.value * width,
                          0,
                        ),
                        child: Text(
                          "Musik Sedang Diputar: ${musicList.firstWhere((music) => music.musicPath == currentMusicPath).title}",
                          style: TextStyle(
                              fontSize: width * 0.05, color: Colors.blue),
                        ),
                      );
                    },
                  )
                : const Text(
                    "Musik Tidak Diputar",
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),

            SizedBox(height: height * 0.02),
            // Tombol Putar Musik
            ElevatedButton(
              onPressed: () {
                _playMusic(musicList[0].musicPath);
                _controller.repeat(reverse: false);
              },
              child: const Text('Putar Musik'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.1, vertical: height * 0.02),
                textStyle: TextStyle(fontSize: width * 0.04),
              ),
            ),
            SizedBox(height: height * 0.02),
            // Kontrol pemutaran musik
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.play_arrow, color: Colors.blue),
                  onPressed: () {
                    if (!isPlaying) {
                      _playMusic(musicList[0].musicPath);
                      _controller.repeat(
                          reverse: false); // Mulai animasi berjalan
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.pause, color: Colors.blue),
                  onPressed: () {
                    if (isPlaying) {
                      _pauseMusic();
                      _controller.stop(); // Hentikan animasi
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.stop, color: Colors.blue),
                  onPressed: () {
                    if (isPlaying) {
                      _stopMusic();
                      _controller.stop(); // Hentikan animasi
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: height * 0.02),
            // List musik
            Expanded(
              child: ListView.builder(
                itemCount: musicList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.01),
                    child: MusicCard(
                      music: musicList[index],
                      onPlay: _playMusic,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
