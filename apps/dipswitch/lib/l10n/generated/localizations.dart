import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'localizations_en.dart';

/// Callers can lookup localized strings with an instance of FGCOSLocalizations
/// returned by `FGCOSLocalizations.of(context)`.
///
/// Applications need to include `FGCOSLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: FGCOSLocalizations.localizationsDelegates,
///   supportedLocales: FGCOSLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the FGCOSLocalizations.supportedLocales
/// property.
abstract class FGCOSLocalizations {
  FGCOSLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static FGCOSLocalizations of(BuildContext context) {
    return Localizations.of<FGCOSLocalizations>(context, FGCOSLocalizations)!;
  }

  static const LocalizationsDelegate<FGCOSLocalizations> delegate = _FGCOSLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// The title for the unsupported build dialog
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get unsupportedTitle;

  /// The content for the unsupported build dialog
  ///
  /// In en, this message translates to:
  /// **'Unsupported build detected'**
  String get unsupportedContent;

  /// OK button for ContentDialog widgets
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get okButton;

  /// Not now button for ContentDialog widgets
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNowButton;

  /// The text for the restart dialog
  ///
  /// In en, this message translates to:
  /// **'You must restart your computer for the changes to take effect'**
  String get restartDialog;

  /// The text for expandable descriptions
  ///
  /// In en, this message translates to:
  /// **'More information'**
  String get moreInformation;

  ///
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get onStatus;

  ///
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get offStatus;

  /// The label for Home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get pageHome;

  /// The label for Security
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get pageSecurity;

  /// The label for Usability
  ///
  /// In en, this message translates to:
  /// **'Usability'**
  String get pageUsability;

  /// The label for Performance
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get pagePerformance;

  /// The label for Windows Updates
  ///
  /// In en, this message translates to:
  /// **'Windows Updates'**
  String get pageUpdates;

  /// The label for Miscellaneous
  ///
  /// In en, this message translates to:
  /// **'Miscellaneous'**
  String get pageMiscellaneous;

  /// The label for Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get pageSettings;

  /// A placeholder for AutoSuggestionBox
  ///
  /// In en, this message translates to:
  /// **'Find a setting'**
  String get suggestionBoxPlaceholder;

  /// The welcome text for Home()
  ///
  /// In en, this message translates to:
  /// **'Thanks for using'**
  String get homeWelcome;

  /// The description for Home()
  ///
  /// In en, this message translates to:
  /// **'A tweaking tool for FGCOS.'**
  String get homeDescription;

  /// The text for a button which redirects to the Revision website
  ///
  /// In en, this message translates to:
  /// **'Check out Revision'**
  String get homeReviLink;

  /// The text for a button which redirects to FAQ
  ///
  /// In en, this message translates to:
  /// **'Check out FAQ'**
  String get homeReviFAQLink;

  /// The label for Windows Defender
  ///
  /// In en, this message translates to:
  /// **'Windows Defender'**
  String get securityWDLabel;

  /// The description for Windows Defender
  ///
  /// In en, this message translates to:
  /// **'Windows Defender will protect your PC. This will have a performance impact due to constantly running in the background'**
  String get securityWDDescription;

  /// The description for Windows Defender's button to disable protection
  ///
  /// In en, this message translates to:
  /// **'Disable protections'**
  String get securityWDButton;

  /// The text for the security dialog
  ///
  /// In en, this message translates to:
  /// **'Please disable every protection before completely disabling Windows Defender'**
  String get securityDialog;

  /// The label for UAC
  ///
  /// In en, this message translates to:
  /// **'User Account Control'**
  String get securityUACLabel;

  /// The description for UAC
  ///
  /// In en, this message translates to:
  /// **'Limits application to standard user privileges until an administrator authorizes an elevation'**
  String get securityUACDescription;

  /// The label for Spectre & Meltdown Mitigation
  ///
  /// In en, this message translates to:
  /// **'Spectre & Meltdown Mitigation'**
  String get securitySMLabel;

  /// The description for Spectre & Meltdown Mitigation
  ///
  /// In en, this message translates to:
  /// **'Patches to enable mitigation against Spectre & Meltdown vulnerabilities'**
  String get securitySMDescription;

  /// The label for Notifications
  ///
  /// In en, this message translates to:
  /// **'Windows Notifications'**
  String get usabilityNotifLabel;

  /// The description for Notifications
  ///
  /// In en, this message translates to:
  /// **'Completely toggle Windows notifications'**
  String get usabilityNotifDescription;

  /// The label for Legacy Notification Balloons
  ///
  /// In en, this message translates to:
  /// **'Legacy Notification Balloons'**
  String get usabilityLBNLabel;

  /// The description for Legacy Notification Balloons
  ///
  /// In en, this message translates to:
  /// **'Tray programs on the taskbar will render as balloons instead of toast notifications'**
  String get usabilityLBNDescription;

  /// The label for Inking And Typing Personalization
  ///
  /// In en, this message translates to:
  /// **'Inking And Typing Personalization'**
  String get usabilityITPLabel;

  /// The description for Inking And Typing Personalization
  ///
  /// In en, this message translates to:
  /// **'Windows will learn what you type to improve suggestions when writing'**
  String get usabilityITPDescription;

  /// The label for CapsLock Key
  ///
  /// In en, this message translates to:
  /// **'CapsLock Key'**
  String get usabilityCPLLabel;

  /// The label for New Context Menu
  ///
  /// In en, this message translates to:
  /// **'New Context Menu'**
  String get usability11MRCLabel;

  /// The label for File Explorer Tabs
  ///
  /// In en, this message translates to:
  /// **'File Explorer Tabs'**
  String get usability11FETLabel;

  /// The label for Superfetch
  ///
  /// In en, this message translates to:
  /// **'Superfetch'**
  String get perfSuperfetchLabel;

  /// The description for Superfetch
  ///
  /// In en, this message translates to:
  /// **'Speed up boot time and load programs faster by preloading all of the necessary data into memory. Enabling Superfetch is only recommended for HDD users'**
  String get perfSuperfetchDescription;

  /// The label for Memory Compression
  ///
  /// In en, this message translates to:
  /// **'Memory Compression'**
  String get perfMCLabel;

  /// The description for Memory Compression
  ///
  /// In en, this message translates to:
  /// **'Save memory by compressing unused programs running in the background. Might have a small impact on CPU usage depending on hardware'**
  String get perfMCDescription;

  /// The label for Intel TSX
  ///
  /// In en, this message translates to:
  /// **'Intel TSX'**
  String get perfITSXLabel;

  /// The description for Intel TSX
  ///
  /// In en, this message translates to:
  /// **'Add hardware transactional memory support, which helps speed up the execution of multithreaded software in cost of security'**
  String get perfITSXDescription;

  /// The label for Memory Compression
  ///
  /// In en, this message translates to:
  /// **'Fullscreen Optimizations'**
  String get perfFOLabel;

  /// The description for Memory Compression
  ///
  /// In en, this message translates to:
  /// **'Fullscreen Optimizations may lead to better gaming and app performance when running in fullscreen mode'**
  String get perfFODescription;

  /// The label for Optimizations for windowed games
  ///
  /// In en, this message translates to:
  /// **'Optimizations for windowed games'**
  String get perfOWGLabel;

  /// The description for Optimizations for windowed games
  ///
  /// In en, this message translates to:
  /// **'Improves frame latency by using a new presentation model for DirectX 10 and 11 games that appear in a window or in a borderless window'**
  String get perfOWGDescription;

  /// The label for Optimizations for ACPI C-States
  ///
  /// In en, this message translates to:
  /// **'Disable the ACPI C2 and C3 states'**
  String get perfCStatesLabel;

  /// The description for Optimizations for windowed games
  ///
  /// In en, this message translates to:
  /// **'Disabling ACPI C-states may improve performance and latency, but it will consume more power while idle, potentially reducing battery life'**
  String get perfCStatesDescription;

  /// The subtitle for Filesystem
  ///
  /// In en, this message translates to:
  /// **'Filesystem'**
  String get perfSectionFS;

  /// The label for Last Access Time
  ///
  /// In en, this message translates to:
  /// **'Disable Last Access Time'**
  String get perfLTALabel;

  /// The description for Last Access Time
  ///
  /// In en, this message translates to:
  /// **'Disabling Last Time Access improves the performance of file and directory access, reduces disk I/O load and latency'**
  String get perfLTADescription;

  /// The label for 8.3 Naming
  ///
  /// In en, this message translates to:
  /// **'Disable 8.3 Naming'**
  String get perfEdTLabel;

  /// The description for 8.3 Naming
  ///
  /// In en, this message translates to:
  /// **'8.3 naming is ancient and disabling it will improve NTFS performance and security'**
  String get perfEdTDescription;

  /// The label for Memory Usage
  ///
  /// In en, this message translates to:
  /// **'Increase the limit of paged pool memory to NTFS'**
  String get perfMULabel;

  /// No description provided for @perfMUDescription.
  ///
  /// In en, this message translates to:
  /// **'Increasing the physical memory doesn\'t always increase the amount of paged pool memory available to NTFS. Setting memoryusage to 2 raises the limit of paged pool memory. This might improve performance if your system is opening and closing many files in the same fileset and is not already using large amounts of system memory for other apps or for cache memory. If your computer is already using large amounts of system memory for other apps or for cache memory, increasing the limit of NTFS paged and non-paged pool memory reduces the available pool memory for other processes. This might reduce overall system performance.\n\nDefault is Off'**
  String get perfMUDescription;

  /// The label for Hiding Windows Updates
  ///
  /// In en, this message translates to:
  /// **'Hide the Windows Updates page'**
  String get wuPageLabel;

  /// The description for Hiding Windows Updates
  ///
  /// In en, this message translates to:
  /// **'Showing this page will also enable update notifications'**
  String get wuPageDescription;

  /// The label for Automatic Driver Updates
  ///
  /// In en, this message translates to:
  /// **'Drivers install through Windows Updates'**
  String get wuDriversLabel;

  /// The description for Automatic Driver Updates
  ///
  /// In en, this message translates to:
  /// **'To install drivers in FGCOS, you need to manually check for updates in Settings, as automatic Windows Updates are not supported'**
  String get wuDriversDescription;

  /// The label for Fast Startup & Hibernate
  ///
  /// In en, this message translates to:
  /// **'Fast Startup & Hibernate'**
  String get miscFastStartupLabel;

  /// The description for Fast Startup & Hibernate
  ///
  /// In en, this message translates to:
  /// **'Windows will save the current session to the hibernate (hiberfil.sys) file on disk in order to start your system faster on the next boot. This doesn\'t affect reboots.\nIt\'s disabled by default since it can make the system unstable in certain cases, like when dual-booting or upgrading the system'**
  String get miscFastStartupDescription;

  /// The label for Network and GPU monitoring
  ///
  /// In en, this message translates to:
  /// **'Network and GPU monitoring'**
  String get miscTMMonitoringLabel;

  /// The description for Network and GPU monitoring
  ///
  /// In en, this message translates to:
  /// **'Activate the monitoring services for Task Manager'**
  String get miscTMMonitoringDescription;

  /// The description for the MPO Label
  ///
  /// In en, this message translates to:
  /// **'Multiplane overlay (MPO)'**
  String get miscMpoLabel;

  /// The Code snippet for MPO
  ///
  /// In en, this message translates to:
  /// **'Recommended to turn off on Nvidia GTX 16xx, RTX 3xxx and AMD RX 5xxx cards or newer.\nLeaving this on could cause black screens, stuttering, flickering, and other general display problems.'**
  String get miscMpoCodeSnippet;

  /// Default state of Dipswitch update card label
  ///
  /// In en, this message translates to:
  /// **'Check for Dipswitch Updates'**
  String get settingsUpdateLabel;

  /// Default state of Dipswitch update button
  ///
  /// In en, this message translates to:
  /// **'Check for Dipswitch Updates'**
  String get settingsUpdateButton;

  /// Available update button
  ///
  /// In en, this message translates to:
  /// **'Update Available'**
  String get settingsUpdateButtonAvailable;

  /// Prompt for available update button
  ///
  /// In en, this message translates to:
  /// **'Would you like to update Dipswitch to'**
  String get settingsUpdateButtonAvailablePrompt;

  /// Updating status
  ///
  /// In en, this message translates to:
  /// **'Updating'**
  String get settingsUpdatingStatus;

  /// Successful update status
  ///
  /// In en, this message translates to:
  /// **'Updated successfully'**
  String get settingsUpdatingStatusSuccess;

  /// No update status
  ///
  /// In en, this message translates to:
  /// **'No update was found'**
  String get settingsUpdatingStatusNotFound;

  /// The label for Color Theme
  ///
  /// In en, this message translates to:
  /// **'Color Theme'**
  String get settingsCTLabel;

  /// The description for Color Theme
  ///
  /// In en, this message translates to:
  /// **'Switch between light and dark mode, or automatically change the theme with Windows'**
  String get settingsCTDescription;

  /// The label for Show experimental tweaks
  ///
  /// In en, this message translates to:
  /// **'Show experimental tweaks'**
  String get settingsEPTLabel;

  /// The description for Show experimental tweaks
  ///
  /// In en, this message translates to:
  /// **''**
  String get settingsEPTDescription;

  /// Task Killer Title
  ///
  /// In en, this message translates to:
  /// **'Task Killer'**
  String get taskKillerTitle;

  /// No description provided for @taskKillerSystemTasksLabel.
  ///
  /// In en, this message translates to:
  /// **'System Tasks or other users tasks'**
  String get taskKillerSystemTasksLabel;

  /// User Tasks
  ///
  /// In en, this message translates to:
  /// **'User Tasks'**
  String get taskKillerUserTasks;

  /// Kill Selected Tasks
  ///
  /// In en, this message translates to:
  /// **'Kill Selected Tasks'**
  String get taskKillerKillButton;

  /// The description for checking at least one task to kill
  ///
  /// In en, this message translates to:
  /// **'Please check at least one task to kill.'**
  String get taskKillerCheckatLeastOne;

  /// Confirmation message for killing tasks
  ///
  /// In en, this message translates to:
  /// **'If you kill tasks owned by NT AUTHORITY\\SYSTEM, NT AUTHORITY\\NETWORK SERVICE or NT AUTHORITY\\LOCAL SERVICE, it could be possible that it will shutdown your PC. Do you want to proceed?\n\nNote: After killing tasks, you might need to refresh the list again. Note that killing programs with a lot of child processes might take a while.'**
  String get taskKillerWarningMessage;

  /// Cancel
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelString;

  /// I am sure to kill the seleted tasks
  ///
  /// In en, this message translates to:
  /// **'I am sure to kill the seleted tasks'**
  String get taskKillerConfirmToKill;

  /// String to describe the background service on the list of tasks
  ///
  /// In en, this message translates to:
  /// **'[In Background]'**
  String get taskKillerBackgroundService;
}

class _FGCOSLocalizationsDelegate extends LocalizationsDelegate<FGCOSLocalizations> {
  const _FGCOSLocalizationsDelegate();

  @override
  Future<FGCOSLocalizations> load(Locale locale) {
    return SynchronousFuture<FGCOSLocalizations>(lookupFGCOSLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_FGCOSLocalizationsDelegate old) => false;
}

FGCOSLocalizations lookupFGCOSLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return FGCOSLocalizationsEn();
  }

  throw FlutterError(
    'FGCOSLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
