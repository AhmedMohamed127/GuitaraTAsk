import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';

class CallScreen extends StatelessWidget {
  final Call call;

  const CallScreen({
    super.key,
    required this.call,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Room'),
        actions: [
          IconButton(
            icon: const Icon(Icons.call_end, color: Colors.red),
            onPressed: () async {
              await call.leave();
              if (context.mounted) Navigator.of(context).maybePop();
            },
          ),
        ],
      ),
      body: StreamCallContainer(call: call,
        callContentBuilder: (
            BuildContext context,
            Call call,
            CallState callState,
            ) {
          return StreamCallContent(
            call: call,
            callControlsBuilder: (
                BuildContext context,
                Call call,
                CallState callState,
                ) {
              final localParticipant = callState.localParticipant!;
              return StreamCallControls(
                options: [
                  CallControlOption(
                    icon: const Icon(Icons.chat_outlined),
                    onPressed: () {
                      // Open your chat window
                    },
                  ),
                  FlipCameraOption(
                    call: call,
                    localParticipant: localParticipant,
                  ),
                  AddReactionOption(
                    call: call,
                    localParticipant: localParticipant,
                  ),
                  ToggleMicrophoneOption(
                    call: call,
                    localParticipant: localParticipant,
                  ),
                  ToggleCameraOption(
                    call: call,
                    localParticipant: localParticipant,
                  ),
                  LeaveCallOption(
                    call: call,
                    onLeaveCallTap: () {
                      call.leave();
                    },
                  ),
                ],
              );
            },
          );
        },),
    );
  }
}