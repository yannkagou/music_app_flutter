import 'package:flutter/material.dart';

class UploadSongPage extends StatefulWidget {
  const UploadSongPage({super.key});

  @override
  State<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends State<UploadSongPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Upload song"),
    );
  }
}
