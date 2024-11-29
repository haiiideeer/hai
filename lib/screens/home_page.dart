import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'music_page.dart';
import '../widgets/custom_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;

  // Menambahkan GlobalKey untuk mengontrol Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menetapkan key pada Scaffold
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          // Tombol untuk membuka endDrawer
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Menggunakan _scaffoldKey untuk membuka endDrawer
              _scaffoldKey.currentState?.openEndDrawer();
            },
          ),
        ],
      ),
      // Menggunakan endDrawer
      endDrawer: const CustomDrawer(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 60), // Menambahkan jarak vertikal

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: const Text(
                  'Hai-Music',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Animasi Lottie
              Lottie.asset(
                'assets/home_animasi.json',
                height: 250,
                width: 250,
              ),
              const SizedBox(height: 20),
              const Text(
                'Selamat datang di Hai-Music!\n'
                'Jelajahi, dengarkan, dan nikmati pengalaman musik yang tak terlupakan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              // Tombol untuk menuju halaman Music
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MusicPage()),
                  );
                },
                child: const Text('Halaman Musik'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
