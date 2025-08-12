import 'package:flutter/material.dart';
import 'package:guitara_task/uiCall.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

const kStreamApiKey = 'mmhfdzb5evj2';
const kPredefinedRoomId = 'a1Y3sS5MNuOYsJRCAVRkR';
const kUserToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL3Byb250by5nZXRzdHJlYW0uaW8iLCJzdWIiOiJ1c2VyL1RyYW5zbHVjZW50X1ByaW5jZXNzIiwidXNlcl9pZCI6IlRyYW5zbHVjZW50X1ByaW5jZXNzIiwidmFsaWRpdHlfaW5fc2Vjb25kcyI6NjA0ODAwLCJpYXQiOjE3NTUwMDY4MDQsImV4cCI6MTc1NTYxMTYwNH0.9qbIXHE2nIM1C6-GXVBCbpf9CCJMHvod4s_xQs-Hfdk'; // Dev/test token for the userId below

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await [Permission.camera, Permission.microphone].request();

  final userId = 'user${DateTime.now().millisecondsSinceEpoch}';

  final client = StreamVideo(
    kStreamApiKey,
    user: User.regular(
      userId: userId,
      name: userId,
    ),
    userToken: kUserToken,
  );

  final call = client.makeCall(
    callType: StreamCallType.defaultType(),
    id: kPredefinedRoomId,
  );

  await call.getOrCreate();
  await call.join();

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

