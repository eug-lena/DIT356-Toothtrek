import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'setting_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Utils/request.dart';
import '../Utils/widget_util.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool notificationValue = false;

  @override
  void initState() {
    super.initState();
    Request.getNotificationPreference().then((value) {
      setState(() {
        notificationValue = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Consumer<SettingProvider>(
      builder: (context, settingProvider, child) {
        return Scaffold(
          appBar: WidgetUtil.buildNavBar(
              context,
              screenWidth,
              Theme.of(context).colorScheme.onPrimary,
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primary),
          body: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(settingProvider.isDarkMode
                    ? 'assets/background-dark.jpg'
                    : 'assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 100),
                Text(AppLocalizations.of(context)!.setting_title,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 50,
                        fontFamily: "suezone",
                        backgroundColor:
                            Theme.of(context).colorScheme.background)),
                const SizedBox(height: 50),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  padding: const EdgeInsets.all(25),
                  width: 500,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.setting_notification,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 30,
                            fontFamily: "suezone",
                          )),
                      Switch(
                        value: notificationValue,
                        onChanged: (value) {
                          setState(() {
                            notificationValue = value;
                          });
                          Request.setNotificationPreference(value);
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  padding: const EdgeInsets.all(25),
                  width: 500,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.setting_darkMode,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 30,
                              fontFamily: "suezone")),
                      Switch(
                        value: settingProvider.isDarkMode,
                        onChanged: (value) {
                          settingProvider.toggleTheme();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  padding: const EdgeInsets.all(25),
                  width: 500,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.setting_language,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 30,
                            fontFamily: "suezone",
                          )),
                      DropdownButton<String>(
                        value: settingProvider.language,
                        onChanged: (String? newValue) {
                          settingProvider.setLanguage(newValue!);
                        },
                        // get Map of languages from settingProvider
                        items: settingProvider.languages
                            .map((key, value) {
                              return MapEntry(
                                  key,
                                  DropdownMenuItem<String>(
                                    value: key,
                                    child: Text(value),
                                  ));
                            })
                            .values
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
