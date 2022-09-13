import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';

class FishRecommendor extends StatefulWidget {
  const FishRecommendor({Key? key}) : super(key: key);

  @override
  State<FishRecommendor> createState() => Fish_RecommendorState();
}

class Fish_RecommendorState extends State<FishRecommendor> {
  PlatformFile? _file;
  String? title;
  String? origin;
  int? price;
  String? imageUrl;
  List marbresList = [];

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.single;
      setState(() {
        _file = file;
      });
    } else {
      MotionToast.info(description: const Text('No file selected'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Fish Recommendor'),
      ),
      body: Center(
        child: _file == null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'You can select a file to predict the fish species',
                  ),
                  ElevatedButton(
                    onPressed: pickFile,
                    child: const Text('Select File'),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'You have selected a file: ${_file!.name}',
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _file = null;
                      });
                    },
                    child: const Text('Sumbit File'),
                  ),
                ],
              ),
      ),
    );
  }
}
