#include "include/bouncing_card/bouncing_card_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "bouncing_card_plugin.h"

void BouncingCardPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  bouncing_card::BouncingCardPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
