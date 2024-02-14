import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class ArabicNumbersPage extends StatelessWidget {
  final player = AudioPlayer();
  final List<String> arabicNumbers = [
    '٠',
    '١',
    '٢',
    '٣',
    '٤',
    '٥',
    '٦',
    '٧',
    '٨',
    '٩'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chiffres en Arabe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCategory(
                'Chiffres en Arabe', arabicNumbers, 'audio/chiffAr.mp3'),
          ],
        ),
      ),
    );
  }

  Widget _buildCategory(String title, List<String> items, String audioPath) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: items.map((item) {
            return _buildItem(item, audioPath);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildItem(String title, String audioPath) {
    return ElevatedButton(
      onPressed: () {
        playSound();
      },
      child: Text(
        title,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  Future<void> playSound() async {
    String soundPath =
        'audio/chiifAr.mp3'; //You don't need to include assets/ because AssetSource assume that you have sound in your assets folder.
    await player.play(AssetSource(soundPath));
  }
}
