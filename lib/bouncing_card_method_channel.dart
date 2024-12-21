import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'bouncing_card_platform_interface.dart';

/// An implementation of [BouncingCardPlatform] that uses method channels.
class MethodChannelBouncingCard extends BouncingCardPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('bouncing_card');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
