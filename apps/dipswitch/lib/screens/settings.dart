import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:dipswitch/l10n/generated/localizations.dart';
import 'package:dipswitch/theme.dart';
import 'package:dipswitch/utils.dart';
import 'package:dipswitch/widgets/card_highlight.dart';
import 'package:win32_registry/win32_registry.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as msicons;

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late ThemeMode theme;
  String updateTitle = "Check for Updates";

  @override
  Widget build(BuildContext context) {
    final appTheme = context.watch<AppTheme>();

    return ScaffoldPage.scrollable(
      resizeToAvoidBottomInset: false,
      header: PageHeader(
        title: Text(FGCOSLocalizations.of(context).pageSettings),
      ),
      children: [
        CardHighlight(
          icon: msicons.FluentIcons.paint_brush_20_regular,
          label: FGCOSLocalizations.of(context).settingsCTLabel,
          description: FGCOSLocalizations.of(context).settingsCTDescription,
          child: ComboBox(
            value: appTheme.themeMode,
            onChanged: appTheme.updateThemeMode,
            items: [
              ComboBoxItem(
                value: ThemeMode.system,
                child: Text(ThemeMode.system.name.uppercaseFirst()),
              ),
              ComboBoxItem(
                value: ThemeMode.light,
                child: Text(ThemeMode.light.name.uppercaseFirst()),
              ),
              ComboBoxItem(
                value: ThemeMode.dark,
                child: Text(ThemeMode.dark.name.uppercaseFirst()),
              ),
            ],
          ),
        ),
        CardHighlightSwitch(
          icon: msicons.FluentIcons.warning_20_regular,
          label: FGCOSLocalizations.of(context).settingsEPTLabel,
          // description: FGCOSLocalizations.of(context).settingsEPTDescription,
          switchBool: expBool,
          function: (value) {
            setState(() {
              if (value) {
                writeRegistryDword(Registry.localMachine,
                    r'SOFTWARE\Revision\Dipswitch', 'Experimental', 1);
              } else {
                writeRegistryDword(Registry.localMachine,
                    r'SOFTWARE\Revision\Dipswitch', 'Experimental', 0);
              }
              expBool = value;
            });
          },
        ),
        CardHighlight(
          label: FGCOSLocalizations.of(context).settingsUpdateLabel,
          icon: msicons.FluentIcons.arrow_clockwise_20_regular,
          child: FilledButton(
            child: Text(updateTitle),
            onPressed: () async {
              Directory tempDir = await getTemporaryDirectory();
              PackageInfo packageInfo = await PackageInfo.fromPlatform();
              int currentVersion =
                  int.parse(packageInfo.version.replaceAll(".", ""));
              // TODO: change this to use the right github repo
              Map<String, dynamic> data = await Network.getJSON(
                  "https://api.github.com/repos/meetrevision/revision-tool/releases/latest");
              int latestVersion =
                  int.parse(data["tag_name"].toString().replaceAll(".", ""));
              if (latestVersion > currentVersion) {
                setState(() {
                  updateTitle =
                      FGCOSLocalizations.of(context).settingsUpdateButton;
                });
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context,
                  builder: (context) => ContentDialog(
                    title: Text(FGCOSLocalizations.of(context)
                        .settingsUpdateButtonAvailable),
                    content: Text(
                        "${FGCOSLocalizations.of(context).settingsUpdateButtonAvailablePrompt} ${data["tag_name"]}?"),
                    actions: [
                      FilledButton(
                        child: Text(FGCOSLocalizations.of(context).okButton),
                        onPressed: () async {
                          setState(() {
                            updateTitle =
                                "${FGCOSLocalizations.of(context).settingsUpdatingStatus}...";
                          });
                          Navigator.pop(context);
                          await Network.downloadNewVersion(
                              data["assets"][0]["browser_download_url"],
                              tempDir.path);
                          setState(() {
                            updateTitle = FGCOSLocalizations.of(context)
                                .settingsUpdatingStatusSuccess;
                          });
                        },
                      ),
                      Button(
                        child:
                            Text(FGCOSLocalizations.of(context).notNowButton),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              } else {
                setState(() {
                  updateTitle = FGCOSLocalizations.of(context)
                      .settingsUpdatingStatusNotFound;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
