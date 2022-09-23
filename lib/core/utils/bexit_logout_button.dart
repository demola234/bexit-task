
import 'package:bex_it/core/utils/config.dart';
import 'package:flutter/material.dart';

class BexitLogout extends StatelessWidget {
  BexitLogout({
    Key? key,
    required this.onTap,
    required this.text,
    this.showLoading,
  }) : super(key: key);

  final void Function() onTap;
  final String text;
  final bool? showLoading;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 72,
            width: context.screenWidth(),
            decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: showLoading != null && showLoading!
                ? Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                        // size: 30,
                      ),
                    ))
                : Align(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: Config.h3(context).copyWith(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    )),
          ),
        ),
      ),
    );
  }
}
