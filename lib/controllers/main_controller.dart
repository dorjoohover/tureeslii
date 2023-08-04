import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tureeslii/controllers/auth_controller.dart';
import 'package:tureeslii/model/models.dart';
import 'package:tureeslii/provider/api_prodiver.dart';
import 'package:tureeslii/shared/constants/enums.dart';

class MainController extends GetxController
    with StateMixin<User>, WidgetsBindingObserver {
  final ApiRepository _apiRepository = Get.find();
  final authController = Get.put(AuthController(apiRepository: Get.find()));

  final showPerformanceOverlay = false.obs;
  final currentIndex = 0.obs;
  final isLoading = false.obs;
  final rxUser = Rxn<User?>();
  final currentUserType = 'user'.obs;
  final our = false.obs;
  final loading = false.obs;
  final savedPosts = <Post>[].obs;
  User? get user => rxUser.value;
  set user(value) => rxUser.value = value;

  getUser(User user) {
    change(user, status: RxStatus.success());
    update();
    getSavedPost();
  }

  logoutUser() {
    change(User(), status: RxStatus.empty());
    update();
  }

  getSavedPost() async {
    try {
      final res = await _apiRepository.getSavedPosts();
      savedPosts.value = res;

      return res;
    } on DioException catch (e) {
      print(e);
    }
  }

  Future<bool> togglePost({required int id, Post? post}) async {
    try {
      final res;
      bool result = false;

      if (savedPosts.where((post) => post.id == id).isEmpty) {
        res = await _apiRepository.removeBookmark(id);
        result = false;
      } else {
        res = await _apiRepository.saveBookmark(id);

        result = true;
      }

      if (res) {
        getSavedPost();
      }
      return result;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<bool> rentRequest(int postId, int startDate, int duration) async {
    try {
      ErrorHandler res =
          await _apiRepository.rentRequest(postId, startDate, duration);
      if (!res.success!) {
        Get.snackbar('Алдаа', res.message ?? '');
      }
      return res.success!;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    return await _apiRepository.updateUser(user);
  }

  Future<void> setupApp() async {
    isLoading.value = true;
    try {
      // user = await _apiRepository.getUser();
      change(user, status: RxStatus.success());

      isLoading.value = false;
    } on DioError catch (e) {
      isLoading.value = false;

      Get.find<SharedPreferences>().remove(StorageKeys.token.name);
      update();
    }
  }

  @override
  void onInit() async {
    await setupApp();
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  @override
  onReady() {
    super.onReady();
  }
}
