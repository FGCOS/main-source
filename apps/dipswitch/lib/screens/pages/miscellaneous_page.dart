import 'package:fluent_ui/fluent_ui.dart';
import 'package:dipswitch/l10n/generated/localizations.dart';
import 'package:dipswitch/utils.dart';
import 'package:dipswitch/widgets/card_highlight.dart';
import 'package:win32_registry/win32_registry.dart';
import 'package:process_run/shell_run.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as msicons;

class MiscellaneousPage extends StatefulWidget {
  const MiscellaneousPage({super.key});

  @override
  State<MiscellaneousPage> createState() => _MiscellaneousPageState();
}

class _MiscellaneousPageState extends State<MiscellaneousPage> {
  bool fsbBool = readRegistryInt(
          RegistryHive.localMachine,
          r'System\ControlSet001\Control\Session Manager\Power',
          'HiberbootEnabled') ==
      1;
  bool tmmBool = readRegistryInt(RegistryHive.localMachine,
              r'SYSTEM\ControlSet001\Services\GraphicsPerfSvc', 'Start') ==
          2 &&
      readRegistryInt(RegistryHive.localMachine,
              r'SYSTEM\ControlSet001\Services\Ndu', 'Start') ==
          2;
  bool mpoBool = readRegistryInt(RegistryHive.localMachine,
          r'SOFTWARE\Microsoft\Windows\Dwm', 'OverlayTestMode') !=
      5;
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      header: PageHeader(
        title: Text(FGCOSLocalizations.of(context).pageMiscellaneous),
      ),
      children: [
        CardHighlightSwitch(
          icon: msicons.FluentIcons.weather_hail_night_20_regular,
          label: FGCOSLocalizations.of(context).miscFastStartupLabel,
          codeSnippet:
              FGCOSLocalizations.of(context).miscFastStartupDescription,
          switchBool: fsbBool,
          function: (value) async {
            setState(() {
              fsbBool = value;
            });
            if (fsbBool) {
              writeRegistryDword(
                  Registry.localMachine,
                  r'System\ControlSet001\Control\Session Manager\Power',
                  'HiberbootEnabled',
                  1);
              writeRegistryDword(
                  Registry.localMachine,
                  r'Software\Policies\Microsoft\Windows\System',
                  'HiberbootEnabled',
                  1);
              writeRegistryDword(
                  Registry.localMachine,
                  r'Software\Policies\Microsoft\Windows\System',
                  'ShowHibernateOption',
                  1);
              writeRegistryDword(Registry.localMachine,
                  r'SYSTEM\ControlSet001\Control\Power', 'HibernateEnabled', 1);
              await Shell().run(r'''
                     powercfg -h on
                     wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:true >NUL
                     wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:true >NUL
                     wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:true >NUL
                    ''');
            } else {
              writeRegistryDword(
                  Registry.localMachine,
                  r'System\ControlSet001\Control\Session Manager\Power',
                  'HiberbootEnabled',
                  0);
              writeRegistryDword(
                  Registry.localMachine,
                  r'Software\Policies\Microsoft\Windows\System',
                  'HiberbootEnabled',
                  0);
              writeRegistryDword(
                  Registry.localMachine,
                  r'Software\Policies\Microsoft\Windows\System',
                  'ShowHibernateOption',
                  0);
              writeRegistryDword(Registry.localMachine,
                  r'SYSTEM\ControlSet001\Control\Power', 'HibernateEnabled', 0);
              await Shell().run(r'''
                     powercfg -h off
                     wevtutil sl Microsoft-Windows-SleepStudy/Diagnostic /e:false >NUL
                     wevtutil sl Microsoft-Windows-Kernel-Processor-Power/Diagnostic /e:false >NUL
                     wevtutil sl Microsoft-Windows-UserModePowerService/Diagnostic /e:false >NUL
                    ''');
            }
          },
        ),
        CardHighlightSwitch(
          icon: FluentIcons.task_manager,
          label: FGCOSLocalizations.of(context).miscTMMonitoringLabel,
          description:
              FGCOSLocalizations.of(context).miscTMMonitoringDescription,
          switchBool: tmmBool,
          function: (value) async {
            setState(() {
              tmmBool = value;
            });
            if (tmmBool) {
              writeRegistryDword(Registry.localMachine,
                  r'SYSTEM\ControlSet001\Services\GraphicsPerfSvc', 'Start', 2);
              writeRegistryDword(Registry.localMachine,
                  r'SYSTEM\ControlSet001\Services\Ndu', 'Start', 2);
              await Shell().run(r'''
                    sc start GraphicsPerfSvc
                    sc start Ndu
                    ''');
            } else {
              writeRegistryDword(Registry.localMachine,
                  r'SYSTEM\ControlSet001\Services\GraphicsPerfSvc', 'Start', 4);
              writeRegistryDword(Registry.localMachine,
                  r'SYSTEM\ControlSet001\Services\Ndu', 'Start', 4);
            }
          },
        ),
        CardHighlightSwitch(
          icon: msicons.FluentIcons.window_settings_20_regular,
          label: FGCOSLocalizations.of(context).miscMpoLabel,
          codeSnippet: FGCOSLocalizations.of(context).miscMpoCodeSnippet,
          switchBool: mpoBool,
          function: (value) async {
            setState(() {
              mpoBool = value;
            });
            if (mpoBool) {
              deleteRegistry(Registry.localMachine,
                  r'SOFTWARE\Microsoft\Windows\Dwm', 'OverlayTestMode');
            } else {
              writeRegistryDword(Registry.localMachine,
                  r'SOFTWARE\Microsoft\Windows\Dwm', 'OverlayTestMode', 5);
            }
          },
        )
      ],
    );
  }
}
