import 'dart:io';

import 'package:dipswitch/screens/pages/task_killer.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:process_run/shell_run.dart';
import 'package:dipswitch/l10n/generated/localizations.dart';
import 'package:dipswitch/screens/pages/miscellaneous_page.dart';
import 'package:dipswitch/screens/pages/performance_page.dart';
import 'package:dipswitch/screens/pages/security_page.dart';
import 'package:dipswitch/screens/pages/updates_page.dart';
import 'package:dipswitch/screens/pages/usability_page.dart';
import 'package:dipswitch/screens/pages/usability_page_two.dart';
import 'package:dipswitch/screens/settings.dart';
import 'package:dipswitch/utils.dart';
import 'package:win32_registry/win32_registry.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart' as msicons;
import 'package:window_plus/window_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? topIndex;
  bool maximize = true;

  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();

  AutoSuggestBoxItem? selectedPage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasFluentTheme(context));
    // final theme = FluentTheme.of(context);

    final List<NavigationPaneItem> items = [
      PaneItem(
        icon: const Icon(
          msicons.FluentIcons.home_24_regular,
          size: 20,
        ),
        title: Text(FGCOSLocalizations.of(context).pageHome),
        body: const Home(),
      ),
      PaneItem(
        icon: const Icon(
          msicons.FluentIcons.window_shield_24_regular,
          size: 20,
        ),
        title: Text(FGCOSLocalizations.of(context).pageSecurity),
        body: const SecurityPage(),
      ),
      w11
          ? PaneItemExpander(
              icon: const Icon(
                msicons.FluentIcons.search_square_24_regular,
                size: 20,
              ),
              title: Text(FGCOSLocalizations.of(context).pageUsability),
              body: const UsabilityPage(),
              items: [
                PaneItem(
                  icon: const Icon(
                    msicons.FluentIcons.window_apps_24_regular,
                    size: 20,
                  ),
                  title: const Text('Windows 11'),
                  body: const UsabilityPageTwo(),
                ),
              ],
            )
          : PaneItem(
              icon: const Icon(
                msicons.FluentIcons.search_square_24_regular,
                size: 20,
              ),
              title: Text(FGCOSLocalizations.of(context).pageUsability),
              body: const UsabilityPage(),
            ),
      PaneItem(
        icon: const Icon(
          msicons.FluentIcons.top_speed_24_regular,
          size: 20,
        ),
        title: Text(FGCOSLocalizations.of(context).pagePerformance),
        body: const PerformancePage(),
      ),
      PaneItem(
        icon: const Icon(
          msicons.FluentIcons.dual_screen_update_24_regular,
          size: 20,
        ),
        title: Text(FGCOSLocalizations.of(context).pageUpdates),
        body: const UpdatesPage(),
      ),
      PaneItem(
        icon: const Icon(
          msicons.FluentIcons.toolbox_24_regular,
          size: 20,
        ),
        title: Text(FGCOSLocalizations.of(context).pageMiscellaneous),
        body: const MiscellaneousPage(),
      ),
      PaneItem(
        icon: const Icon(
          msicons.FluentIcons.arrow_sync_dismiss_24_regular,
          size: 20,
        ),
        title: const Text('Task Killer'),
        body: const TaskKillerPage(),
      ),
    ];

    return SafeArea(
      child: NavigationView(
        key: viewKey,
        contentShape: const RoundedRectangleBorder(
          side: BorderSide(width: 0, color: Colors.transparent),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
          ),
        ),
        appBar: NavigationAppBar(
          automaticallyImplyLeading: false,
          title: const Text('Dipswitch'),
          actions: WindowCaption(),
        ),
        pane: NavigationPane(
          selected: topIndex ?? 0,
          onChanged: (index) => setState(() => topIndex = index),
          displayMode: MediaQuery.of(context).size.width >= 800
              ? PaneDisplayMode.open
              : PaneDisplayMode.minimal,
          header: SizedBox(
            height: 90,
            // height: kOneLineTileHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 5.0),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  child: Image.file(
                    width: 60,
                    height: 60,
                    File(
                        '${Registry.openPath(RegistryHive.currentUser, path: r'Volatile Environment').getValueAsString("LOCALAPPDATA")!}\\Temp\\${Registry.openPath(RegistryHive.currentUser, path: r'Volatile Environment').getValueAsString("USERNAME")!}.bmp'),
                  ),
                ),
                const SizedBox(width: 13.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Registry.openPath(RegistryHive.currentUser,
                              path: r'Volatile Environment')
                          .getValueAsString("USERNAME")!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    const Text(
                      "Current user logged in",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          autoSuggestBox: AutoSuggestBox(
            key: searchKey,
            trailingIcon: const Padding(
              padding: EdgeInsets.only(right: 7.0, bottom: 2),
              child: Icon(
                msicons.FluentIcons.search_20_regular,
              ),
            ),
            focusNode: searchFocusNode,
            controller: searchController,
            placeholder:
                FGCOSLocalizations.of(context).suggestionBoxPlaceholder,
            items: items.whereType<PaneItem>().map((page) {
              assert(page.title is Text);
              final text = (page.title as Text).data!;
              return AutoSuggestBoxItem(
                value: text,
                label: text,
                onSelected: () async {
                  final itemIndex = NavigationPane(
                    items: items,
                  ).effectiveIndexOf(page);

                  setState(() => topIndex = itemIndex);
                  await Future.delayed(const Duration(milliseconds: 17));
                  searchController.clear();
                },
              );
            }).toList(),
            onSelected: (item) {
              setState(() => selectedPage = item);
            },
          ),

          autoSuggestBoxReplacement: const Icon(FluentIcons.search),
          // footerItems: searchValue.isNotEmpty ? [] : footerItems,
          items: items,
          footerItems: [
            PaneItem(
              icon: const Icon(
                msicons.FluentIcons.settings_24_regular,
                size: 20,
              ),
              title: Text(FGCOSLocalizations.of(context).pageSettings),
              body: const SettingsPage(),
            ),
            PaneItemSeparator(color: Colors.transparent),
          ],
        ),
        onOpenSearch: () {
          searchFocusNode.requestFocus();
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      resizeToAvoidBottomInset: false,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (MediaQuery.of(context).size.height >= 400) ...[
                const SizedBox(
                  height: 100,
                )
              ] else ...[
                const SizedBox(
                  height: 25,
                )
              ],
              Text(
                FGCOSLocalizations.of(context).homeWelcome,
                style: FluentTheme.of(context).brightness.isDark
                    ? const TextStyle(fontSize: 16, color: Color(0xB7FFFFFF))
                    : const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 117, 117, 117)),
              ),
              const Text(
                "Dipswitch",
                style: TextStyle(fontSize: 28),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  FGCOSLocalizations.of(context).homeDescription,
                  style: FluentTheme.of(context).brightness.isDark
                      ? const TextStyle(fontSize: 16, color: Color(0xB7FFFFFF))
                      : const TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 117, 117, 117)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 5),
                child: SizedBox(
                  width: 175,
                  child: Button(
                    child: Text(FGCOSLocalizations.of(context).homeReviLink),
                    onPressed: () async {
                      await run(
                          "rundll32 url.dll,FileProtocolHandler https://www.fgcos.cc");
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SizedBox(
                  width: 175,
                  child: FilledButton(
                    child: Text(FGCOSLocalizations.of(context).homeReviFAQLink),
                    onPressed: () async {
                      await run(
                          "rundll32 url.dll,FileProtocolHandler https://www.fgcos.cc/dipswitch/faq");
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
