import 'package:flutter_test/flutter_test.dart';
import 'package:bouncing_card/bouncing_card_platform_interface.dart';
import 'package:bouncing_card/bouncing_card_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBouncingCardPlatform
    with MockPlatformInterfaceMixin
    implements BouncingCardPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BouncingCardPlatform initialPlatform = BouncingCardPlatform.instance;

  test('$MethodChannelBouncingCard is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBouncingCard>());
  });

  test('getPlatformVersion', () async {

  });
}
