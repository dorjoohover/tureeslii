import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/routes.dart';

import '../../../shared/index.dart';

class SplashController extends GetxController {
  final token = Rxn<String?>();
  late Worker worker;
  final storage = Get.find<SharedPreferences>();
  final mainController = Get.put(MainController());
  @override
  void onInit() async {
    try {
      final isCurrent = await _isCurrentVersion();
      if (isCurrent == null) {
       
      } else {
        if (isCurrent) {
          _checkAuthStatus();
        } else {
          _showUpdateDialog();
        }
      }
    } on Exception catch (e) {
      print(e);
      
    }
    super.onInit();
  }

  logout() async {
    final storage = Get.find<SharedPreferences>();
    await storage.remove(StorageKeys.token.name);

    token.value = null;
  }

  Future<bool?> _isCurrentVersion() async {
    try {
      return kDebugMode;
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
        print(e.message);
      }
      return null;
    } on Error catch (er) {
      print(er);

      return null;
    }
  }

  /// CHECKING UPDATE VERSION

  _checkAuthStatus() async {
    // await Future.delayed(Duration(milliseconds: 1800));
    worker = ever<String?>(
      token,
      (tkn) {
        if (tkn != null) {
          try {
            Get.toNamed(Routes.main);
          } catch (e) {
            Get.toNamed(Routes.auth);
          }
        } else {
          Get.toNamed(Routes.auth);
        }
      },
    );
    token.value = storage.getString(StorageKeys.token.name);
  }

  // Future<String> getLocalVersion() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   // return packageInfo.version + '.' + packageInfo.buildNumber;
  //   return packageInfo.version;
  // }

  _showUpdateDialog() {
    // Get.defaultDialog(
    //   barrierDismissible: false,
    //   title: 'Update Available',
    //   middleText: 'Please update the app to continue',
    //   textConfirm: 'Update',
    //   confirmTextColor: Colors.white,
    //   onConfirm: () async {
    //     const url = 'https://testflight.apple.com/join/krCWIXJr';
    //     if (await launchUrl(Uri.parse(url))) {
    //       canLaunchUrl(Uri.parse(url));
    //     } else {
    //       throw 'Cannot load url';
    //     }
    //     // StoreLauncher().open(
    //     //   androidAppBundleId: 'com.eve_flashcards',
    //     //   appStoreId: 'id1520000000',
    //     // );
    //   },
    // );
  }

  @override
  void dispose() {
    worker.dispose();
    super.dispose();
  }
}
