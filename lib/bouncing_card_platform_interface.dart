import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'bouncing_card_method_channel.dart';

abstract class BouncingCardPlatform extends PlatformInterface {
  /// Constructs a BouncingCardPlatform.
  BouncingCardPlatform() : super(token: _token);

  static final Object _token = Object();

  static BouncingCardPlatform _instance = MethodChannelBouncingCard();

  /// The default instance of [BouncingCardPlatform] to use.
  ///
  /// Defaults to [MethodChannelBouncingCard].
  static BouncingCardPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BouncingCardPlatform] when
  /// they register themselves.
  static set instance(BouncingCardPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
