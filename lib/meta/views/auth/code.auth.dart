import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:input_flutter/app/constants/controller.constant.dart';
import 'package:input_flutter/components/dialogs/custom_snackbars.dart';
import 'package:input_flutter/components/widgets/my_text_field.dart';
import 'package:input_flutter/core/notifiers/auth.notifier.dart';
import 'package:input_flutter/core/notifiers/connectivity.notifier.dart';
import 'package:input_flutter/core/notifiers/root.page_controller.notifier.dart';
import 'package:input_flutter/meta/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../app/constants/assets.constant.dart';
import '../../../components/widgets/my_elevated_button.dart';

class CodeAuth extends StatefulWidget {
  const CodeAuth({Key? key}) : super(key: key);

  @override
  _CodeAuthState createState() => _CodeAuthState();
}

class _CodeAuthState extends State<CodeAuth>
    with AutomaticKeepAliveClientMixin<CodeAuth> {
  @override
  void initState() {
    Provider.of<ConnectionNotifier>(context, listen: false).initConnectivity();
    super.initState();
  }

  final secretCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool verifying = false;

  void _trySubmit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      setState(() {
        verifying = true;
      });

      if(context.read<ConnectionNotifier>().isOnline){
        // CALL VERIFY METHOD
        context.read<AuthNotifier>().verifySecret(secretCodeController.text).then((value){
          if(value){
            secretCodeController.clear();
            context.read<RootPageNotifier>().animateToIndex(1);
            CustomSnackBar.openIconSnackBar(context, "</${context.read<AuthNotifier>().currentSpyder.name}>", const Icon(Icons.done));
          }else{
            CustomSnackBar.openErrorSnackBar(context, "An error has occurred",);
          }
        });
      }else{
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        CustomSnackBar.openErrorSnackBar(context, "No Internet Connection",);
      }
    }
    setState(() {
      verifying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ScreenUtilInit(
        builder: () => SingleChildScrollView(
              child: Center(
                  child: Form(
                key: _formKey,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 0.5.sh,
                      child: Image.asset(
                        Assets.appLogo,
                        filterQuality: FilterQuality.low,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 0.15.sp,
                    ),
                    Container(
                      width: size.width < 800 ? 0.9.sw.sm : 0.5.sw.sm,
                      margin: EdgeInsets.symmetric(
                          horizontal: 5.sp, vertical: 5.sp),
                      decoration: BoxDecoration(
                          color: AppTheme.darkBackgroundColor.withOpacity(0.9),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.sp, vertical: 5.sp),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                  width:size.width < 800 ? 0.9.sw.sm : 0.45.sw.sm,
                                  child: _buildSecretCodeField()),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: size.width < 800 ? 0.9.sw.sm : 0.45.sw.sm,
                                child: MyElevatedButton(
                                  onPressed: !verifying ? _trySubmit : ()=>{},
                                  buttonText: 'Verify',
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
            ));
  }

  Widget _buildSecretCodeField() {
    return MyTextField(
      controller: secretCodeController,
      borderRadius: 12,
      containerBoxColor: AppTheme.darkBackgroundColor.withOpacity(0.9),
      hintText: 'C:\\User\\Root\\input>Please enter you secret code?',
      suffixIcon: const SizedBox.shrink(),
      keyType: TextInputType.emailAddress,
      validator: (str) {
        if (str == null || str == '') {
          return "Incorrect";
        }
        return null;
      },
      obSecureText: false,
      action: TextInputAction.done,
      onSubmit: (str) {
        !verifying ? _trySubmit() : null;
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
