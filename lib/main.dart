import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'native_service.dart';
import 'ui.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) =>
      const CourseApp(title: 'Практична 14', home: NativeScreen());
}

class NativeScreen extends StatefulWidget {
  const NativeScreen({super.key});
  @override
  State<NativeScreen> createState() => _NativeScreenState();
}

class _NativeScreenState extends State<NativeScreen> {
  final _picker = ImagePicker();
  final _service = NativeService();
  XFile? _photo;
  String _nativeResult = 'Натисніть кнопку, щоб викликати Kotlin-код.';
  String? _cameraMessage;
  bool _takingPhoto = false;
  @override
  void initState() {
    super.initState();
    _recoverPhoto();
  }

  Future<void> _recoverPhoto() async {
    try {
      final response = await _picker.retrieveLostData();
      if (!mounted || response.isEmpty) return;
      if (response.files?.isNotEmpty == true) {
        setState(() => _photo = response.files!.first);
      } else if (response.exception != null) {
        setState(
          () => _cameraMessage = 'Не вдалося відновити фото. Зробіть нове.',
        );
      }
    } on Object {
      /* На платформах без камери відновлювати нічого. */
    }
  }

  Future<void> _callNative() async {
    try {
      final text = await _service.greeting();
      if (mounted) setState(() => _nativeResult = text);
    } on MissingPluginException {
      if (mounted) {
        setState(
          () => _nativeResult =
              'Запустіть Android-збірку та перезапустіть її після зміни Kotlin.',
        );
      }
    } on PlatformException catch (e) {
      if (mounted) {
        setState(() => _nativeResult = 'Помилка платформи: ${e.message}');
      }
    }
  }

  Future<void> _takePhoto() async {
    setState(() {
      _takingPhoto = true;
      _cameraMessage = null;
    });
    try {
      final file = await _picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1600,
        imageQuality: 85,
      );
      if (!mounted) return;
      setState(() {
        if (file != null) {
          _photo = file;
        } else {
          _cameraMessage =
              'Зйомку скасовано. Попереднє фото збережено на екрані.';
        }
      });
    } on Object {
      if (mounted) {
        setState(
          () => _cameraMessage =
              'Камера недоступна. Перевірте дозвіл і наявність камери на пристрої.',
        );
      }
    } finally {
      if (mounted) setState(() => _takingPhoto = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Нативні можливості')),
    body: PageBody(
      children: [
        const Text(
          'Номер 25 → завдання 1. Kotlin повертає статичний рядок «Hi, Mom!».',
        ),
        ElevatedButton(
          onPressed: _callNative,
          child: const Text('Викликати нативний код'),
        ),
        SelectableText(_nativeResult, key: const Key('native-result')),
        const Divider(),
        OutlinedButton.icon(
          onPressed: _takingPhoto ? null : _takePhoto,
          icon: const Icon(Icons.camera_alt_outlined),
          label: Text(_takingPhoto ? 'Очікування камери…' : 'Зробити фото'),
        ),
        if (_cameraMessage != null) Text(_cameraMessage!),
        if (_photo == null)
          const Text('Щойно зроблене фото з’явиться тут.')
        else
          Image.file(
            File(_photo!.path),
            fit: BoxFit.contain,
            semanticLabel: 'Щойно зроблене фото',
            errorBuilder: (_, error, stack) =>
                const Text('Не вдалося прочитати фото. Зробіть нове.'),
          ),
      ],
    ),
  );
}
