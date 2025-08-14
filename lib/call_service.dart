import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'config.dart';

class CallService {
  const CallService();

  Future<Call> initializeAndJoinCall() async {
    final userId = 'user${DateTime.now().millisecondsSinceEpoch}';

    final client = StreamVideo(
      streamApiKey,
      user: User.regular(
        userId: userId,
        name: userId,
      ),
      userToken: userToken,
    );

    final call = client.makeCall(
      callType: StreamCallType.defaultType(),
      id: predefinedRoomId,
    );

    await call.getOrCreate();
    await call.join();

    return call;
  }
}


