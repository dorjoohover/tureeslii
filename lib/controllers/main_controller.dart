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

  // otp
  final otp = "------".obs;

  // change password
  final oldPassword = "".obs;
  final newPassword = "".obs;
  final confirmPassword = "".obs;

  // posts
  final allPosts = <Post>[].obs;
  // own posts
  final ownPosts = <Post>[].obs;

  User? get user => rxUser.value;
  set user(value) => rxUser.value = value;
// orders
  Future<void> getOrders() async {
    try {
      List<Post> res = await _apiRepository.getOwnPosts(0, 10, SortData(), []);
      ownPosts.value = res;
    } catch (e) {
      print(e);
    }
  }

  // posts

  getAllPosts(int page, int limit, SortData sortData,
      List<FilterData> filterData) async {
    try {
      final res = await _apiRepository.getAllPosts(
        page,
        limit,
        sortData,
        filterData,
      );
      allPosts.value = res;

      return res;
    } on DioException catch (e) {
      print(e);
    }
  }

  // saved posts
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

      if (savedPosts.where((post) => post.id == id).isNotEmpty) {
        savedPosts.removeWhere((element) => element.id == id);
        res = await _apiRepository.removeBookmark(id);
      } else {
        savedPosts.add(post!);
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

  Future<bool> rentRequest(
      int postId, int startDate, int duration, String type) async {
    try {
      ErrorHandler res =
          await _apiRepository.rentRequest(postId, startDate, duration, type);
      if (!res.success!) {
        Get.snackbar('Алдаа', res.message ?? '');
      }
      return res.success!;
    } on Exception catch (e) {
      return false;
    }
  }

// profile
  Future<bool> changePassword() async {
    try {
      if (newPassword.value == confirmPassword.value) {
        await _apiRepository.changePassword(
            oldPassword.value, newPassword.value);
        return true;
      } else {
        Get.snackbar('Алдаа', 'Нууц үг таарахгүй байна');
        return false;
      }
    } on DioException catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateUser(User user) async {
    return await _apiRepository.updateUser(user);
  }

  Future<bool> savePersonal(
      String lastname, String firstname, String phone) async {
    bool res = await _apiRepository.savePersonal(lastname, firstname, phone);
    if (res) {
      refreshUser();
    }
    return res;
  }

  refreshUser() async {
    user = await _apiRepository.getUser();
    change(user, status: RxStatus.success());
  }

  Future<void> setupApp() async {
    isLoading.value = true;
    try {
      final res = await _apiRepository.getUser();
      if (res != null) {
        user = res;
        change(user, status: RxStatus.success());
        if (user != null) {
          getSavedPost();
        }
        // isLoading.value = false;
      }
    } on DioException catch (e) {
      isLoading.value = false;

      Get.find<SharedPreferences>().remove(StorageKeys.token.name);

      update();
    }
  }

  Future<void> sendEmailVerification() async {
    await _apiRepository.sendEmailVerifyCode();
  }

  Future<bool> getMobileVerification() async {
    return _apiRepository.getMobileVerifyCode();
  }

  Future<bool> sendMobileVerification() async {
    return _apiRepository.sendMobileVerifyCode(otp.value);
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
