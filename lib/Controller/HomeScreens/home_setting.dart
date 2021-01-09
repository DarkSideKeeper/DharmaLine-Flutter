import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSetting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeSettingState();
  }
}

class _HomeSettingState extends State<HomeSetting> {
  Future<String> getVersionNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Column(
        children: [
          viewAlert(),
        ],
      ),
    );
  }

  AlertDialog viewAlert() {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bodyTextStyle =
        textTheme.bodyText1.apply(color: colorScheme.onPrimary);

    return AlertDialog(
      backgroundColor: colorScheme.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: getVersionNumber(),
              builder: (context, snapshot) => Text(
                'App: ${snapshot.data}',
                style: textTheme.headline4.apply(color: colorScheme.onPrimary),
              ),
            ),
            const SizedBox(height: 24),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    style: bodyTextStyle,
                    text: 'Titipan Sakunwongsalee',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final url = 'https://www.facebook.com/StEpPrOoO';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              '© 2021 OMGWTL TEAM',
              style: bodyTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}
