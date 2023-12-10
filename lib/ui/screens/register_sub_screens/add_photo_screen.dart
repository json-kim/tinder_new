import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tinder_new/ui/widgets/image_portrait.dart';

class AddPhotoScreen extends StatefulWidget {
  final Function(Uint8List) onPhotoChanged;

  const AddPhotoScreen({super.key, required this.onPhotoChanged});

  @override
  AddPhotoScreenState createState() => AddPhotoScreenState();
}

class AddPhotoScreenState extends State<AddPhotoScreen> {
  final picker = ImagePicker();
  Uint8List? _imageBytes;

  Future pickImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      widget.onPhotoChanged(bytes);

      setState(() {
        _imageBytes = bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Add photo',
          style: Theme.of(context).textTheme.headline3,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Container(
                    child: _imageBytes == null
                        ? ImagePortrait(
                            imageType: ImageType.NONE,
                            imagePath: '',
                          )
                        : ImagePortrait(
                            bytes: _imageBytes,
                            imageType: ImageType.MEMORY_IMAGE,
                          ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: _imageBytes == null
                          ? ElevatedButton(
                              onPressed: pickImageFromGallery,
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(20),
                              ),
                              child: const Icon(Icons.add),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
