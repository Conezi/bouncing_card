#ifndef FLUTTER_PLUGIN_BOUNCING_CARD_PLUGIN_H_
#define FLUTTER_PLUGIN_BOUNCING_CARD_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace bouncing_card {

class BouncingCardPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BouncingCardPlugin();

  virtual ~BouncingCardPlugin();

  // Disallow copy and assign.
  BouncingCardPlugin(const BouncingCardPlugin&) = delete;
  BouncingCardPlugin& operator=(const BouncingCardPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace bouncing_card

#endif  // FLUTTER_PLUGIN_BOUNCING_CARD_PLUGIN_H_
