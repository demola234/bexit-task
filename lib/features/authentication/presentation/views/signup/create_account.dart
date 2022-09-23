import 'package:bex_it/core/state/view_state.dart';
import 'package:bex_it/core/utils/config.dart';
import 'package:bex_it/core/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/utils/bexit_button.dart';
import '../../../../../core/utils/bexit_textfield.dart';
import '../../provider/authentication_provider.dart';
import '../login/login.dart';

class SignUp extends ConsumerStatefulWidget {
  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool visible = true;

  @override
  Widget build(BuildContext context) {
    final createAccount = ref.watch(authenticationNotifierProvider);
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                YMargin(80),
                Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          width: 300,
                          child: Text(
                            "Create An Account with Us?",
                            maxLines: 2,
                            style: Config.h2(context).copyWith(
                              color: Colors.black,
                            ),
                          ),
                        )),
                  ],
                ),
                YMargin(80),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(children: [
                    BexItTextFormField(
                      hintText: "Email",
                      controller: email,
                      inputType: TextInputType.text,
                    ),
                    YMargin(20),
                    BexItTextFormField(
                      hintText: "Password",
                      controller: password,
                      inputType: TextInputType.visiblePassword,
                      obscureText: !visible,
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              visible = !visible;
                            });
                          },
                          child: Icon(
                            !visible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Colors.black,
                          )),
                    ),
                  ]),
                ),
                YMargin(40),
                Consumer(
                  builder: (context, watch, child) {
                    final state =
                        watch.read(authenticationNotifierProvider.notifier);

                    return BexItButton(
                        text: "Create Account",
                        showLoading: createAccount.viewState.isLoading,
                        onTap: () async {
                          await state.createAccount(email.text, password.text);
                        });
                  },
                ),
              ],
            ),
          ),
          YMargin(100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account? ",
                style: Config.b2(context),
              ),
              GestureDetector(
                onTap: () {
                  NavigationService().navigateToScreen(Login());
                },
                child: Text(
                  "Login",
                  style: Config.b2(context)
                      .copyWith(color: BexItColor.BexItPrimary),
                ),
              )
            ],
          )
        ]),
      ),
    ));
  }
}
