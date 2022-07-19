import 'package:flutter/material.dart';

import 'anims.dart';

class EditWidget {
  final BuildContext context;

  EditWidget({required this.context});

  bool isDismissedBySystem = false;

  Future show() => showDialog(
      context: context,
      builder: (BuildContext context) {
        return ScaleFade(
          scale: 0.1,
          fade: true,
          curve: Curves.fastLinearToSlowEaseIn,
          child: AlertDialog(
            insetPadding: const EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            scrollable: true,
            content: _buildDialog,
          ),
        );
      }).then((_) {
    isDismissedBySystem = true;
  });

  Widget get _buildDialog => Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: [
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            child: Text(
              '',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.grey.shade800
              ),
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Text(
                "",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.grey
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16.0),
      Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: <Widget>[
            _buildButtonOk,
            const SizedBox(height: 10),
            _buildButtonCancel,
          ],
        ),
      )
    ],
  );

  Widget get _buildButtonOk => SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Colors.blue,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          )),
      onPressed: () {
        dismiss();
      },
      child: Text(
        'Okay',
        textAlign: TextAlign.center,
        style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
      ),
    ),
  );

  Widget get _buildButtonCancel => SizedBox(
    width: double.infinity,
    height: 50,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          primary: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(100),
            ),
          )),
      onPressed: () {
        dismiss();
      },
      child: Text(
        'Cancel',
        textAlign: TextAlign.center,
        style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
      ),
    ),
  );

  dismiss() {
    if (!isDismissedBySystem) {
      Navigator.of(context).pop();
    }
  }
}
