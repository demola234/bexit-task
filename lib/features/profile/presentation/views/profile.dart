import 'dart:io';

import 'package:bex_it/core/utils/bexit_button.dart';
import 'package:bex_it/core/utils/config.dart';
import 'package:bex_it/core/utils/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:images_picker/images_picker.dart';

import '../../../../core/error/toasts.dart';
import '../../../../core/utils/bexit_logout_button.dart';
import '../controller/profile_controller.dart';
import '../provider/profile_provider.dart';
import '../widgets/email_text.dart';
import '../widgets/profile_image.dart';
import '../widgets/profile_items.dart';
import '../widgets/verified_user.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  @override
  Widget build(BuildContext context) {
    final value = ref.watch(getUserIdProvider);
    final getProfile = ref.watch(getProfileUser);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            YMargin(50),

            value.when(
              data: (data) => ProfileImage(data: data),
              loading: () => CircularProgressIndicator(),
              error: ((error, stackTrace) => Container(
                    child: Text("An Error Occurred Fetching Profile Image"),
                  )),
            ),

            YMargin(10),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  value.when(
                      data: (data) => EmailText(data: data),
                      loading: () => CircularProgressIndicator(),
                      error: ((error, stackTrace) => Container(
                            child: Text(
                                "An Error Occurred Fetching Email Address"),
                          ))),
                  XMargin(5),
                  value.when(
                    data: (data) => data.user.status
                        ? VerifiedUser(data: data)
                        : Center(
                            child: Icon(
                            Icons.cancel_rounded,
                            color: Colors.red,
                            size: 18,
                          )),
                    loading: () => CircularProgressIndicator(),
                    error: ((error, stackTrace) => Container()),
                  ),
                ],
              ),
            ),
            YMargin(50),
            // Edit Profile
            BexItButton(
                onTap: () {
                  selectImage();
                },
                text: "Edit Profile Image"),
            YMargin(35),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: getProfile.when(
                  data: (data) => ProfileItems(data: data),
                  loading: () => CircularProgressIndicator(),
                  error: ((error, stackTrace) => Container(
                        child: Text("An Error Occurred Fetching Profile Items"),
                      )),
                )),
            Spacer(),
            BexitLogout(
              onTap: () {
                cache.clear();
                NavigationService().popToFirst();
              },
              text: "Log Out",
            )
          ],
        ),
      ),
    );
  }

  List<File> image = [];
  void selectImage() async {
    List<Media>? res = await ImagesPicker.pick(
      cropOpt: CropOption(
        aspectRatio: CropAspectRatio.custom,
        cropType: CropType.rect,
      ),
      count: 1,
      pickType: PickType.image,
    );

    if (res != null) {
      setState(() {
        image.addAll(res.map((e) => File(e.path)));
        if (kDebugMode) {
          print(image.first.path);
        }
      });
      ref.watch(profileNotifierProvider.notifier).editProfileImage(image[0]);
    } else if (res == null) {
      Toasts.showErrorToast("No Image Selected");
    }
  }
}
