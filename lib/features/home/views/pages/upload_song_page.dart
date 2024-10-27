import 'dart:io';

import 'package:client/core/constants/app_text_styles.dart';
import 'package:client/core/constants/constants.dart';
import 'package:client/core/constants/kColors.dart';
import 'package:client/core/local_storage/sharedPref.dart';
import 'package:client/core/widget/custom_field.dart';
import 'package:client/features/home/utils/utils.dart';
import 'package:client/features/home/views/widgets/audio_wave.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
// import 'package:client/features/auth/models/userModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadSongPage extends StatefulWidget {
  const UploadSongPage({super.key});

  @override
  State<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends State<UploadSongPage> {
  final service = SharedPreferencesServices();
  final artistController = TextEditingController();
  final songController = TextEditingController();
  Color selectedColor = Kcolors.cardColor;
  File? selectedImage;
  File? selectedAudio;

  void selectAudio() async {
    final pickedAudio = await pickAudio();
    if (pickedAudio != null) {
      setState(() {
        selectedAudio = pickedAudio;
      });
    }
  }

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  @override
  void initState() {
    final getUser = service.getUserFromSharedPref();
    debugPrint("The user ======> $getUser");
    super.initState();
  }

  @override
  void dispose() {
    artistController.dispose();
    songController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Texts.UPLOAD_SONG),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.check))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: selectImage,
                child: selectedImage != null
                    ? SizedBox(
                        height: 150.h,
                        width: double.infinity,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(selectedImage!)))
                    : DottedBorder(
                        color: Kcolors.borderColor,
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: SizedBox(
                          height: 150.h,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                size: 40,
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                Texts.SELECT_SONG_THUMBNAIL,
                                style: TextStyles.normalWhite,
                              )
                            ],
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 40.h,
              ),
              selectedAudio != null
                  ? AudioWave(path: selectedAudio!.path)
                  : CustomField(
                      hintext: Texts.PICK_SONG,
                      controller: null,
                      readonly: true,
                      onTap: selectAudio,
                    ),
              SizedBox(
                height: 20.h,
              ),
              CustomField(
                hintext: Texts.SONG_NAME,
                controller: songController,
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomField(
                hintext: Texts.ARTIST,
                controller: artistController,
              ),
              SizedBox(
                height: 20.h,
              ),
              ColorPicker(
                pickersEnabled: const {ColorPickerType.wheel: true},
                color: selectedColor,
                onColorChanged: (Color color) {
                  setState(() {
                    selectedColor = color;
                  });
                },
                heading: const Text("Select color"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
