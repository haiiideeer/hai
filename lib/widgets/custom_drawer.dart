import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_page.dart';
import 'music_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'package:hai_flutter/screens/login_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  // Fungsi untuk membuka URL dengan url_launcher
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url); // Membuka URL
    } else {
      throw 'Could not launch $url'; // Menampilkan error jika URL tidak bisa dibuka
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header / Profil Pengguna di bagian atas Drawer
          const UserAccountsDrawerHeader(
            accountName: Text('Haider Muhammad Iqbal'),
            accountEmail: Text('haider101602@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.blue,
              backgroundImage: AssetImage('assets/logo.png'),
            ),
            decoration: BoxDecoration(
              color: Colors.blue, // Ganti dengan warna yang Anda inginkan
            ),
          ),
          // Menu Navigasi
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.music_note),
            title: const Text('Music'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MusicPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          // Menu Instagram
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Instagram'),
            onTap: () {
              _launchURL(
                  'https://www.instagram.com/haiiideer'); // Ganti dengan username Instagram Anda
            },
          ),
          // Menu WhatsApp
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('WhatsApp'),
            onTap: () {
              _launchURL(
                  'https://wa.me/082199120740'); // Ganti dengan nomor WhatsApp Anda (misalnya: https://wa.me/1234567890)
            },
          ),
          const Divider(), // Pembatas antar item menu
          // Fungsi Logout dengan Konfirmasi
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () {
              // Menambahkan konfirmasi logout
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Apakah Anda yakin ingin logout?'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Batal'),
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); // Menutup dialog jika batal
                        },
                      ),
                      TextButton(
                        child: const Text('Logout'),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                          );
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const Divider(), // Pembatas antar grup menu
        ],
      ),
    );
  }
}
