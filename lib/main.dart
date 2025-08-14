import 'package:flutter/material.dart';
import 'package:guitara_task/uiCall.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'call_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [Permission.camera, Permission.microphone].request();

  final call = await const CallService().initializeAndJoinCall();

  runApp(GroupCallApp(call: call));
}

class GroupCallApp extends StatelessWidget {
  final Call call;
  const GroupCallApp({super.key, required this.call});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Group Call',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: CallScreen(call: call,),
    );
  }
}

