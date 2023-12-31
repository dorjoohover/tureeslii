import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/controllers/notification_controller.dart';
import 'package:tureeslii/pages/menu/menu_view.dart';
import 'package:tureeslii/pages/pages.dart';
import 'package:tureeslii/shared/index.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> views = [
    const LocationView(),
    const BookmarkView(),
    const NotificationView(),
    OrderView(),
    const MenuView(),
  ];
  int currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());
    final notificationController = Get.put(NotificationController());

    return GetBuilder<MainController>(
      init: MainController(),
      builder: (controller) => controller.obx(
          onLoading: const SplashView(),
          onError: (error) => Stack(
                children: [
                  const SplashView(),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Align(
                      child: Material(
                        borderRadius: BorderRadius.circular(30),
                        borderOnForeground: true,
                        child: AnimatedContainer(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          height: 400,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                  child: Text(
                                    "Check your internet connection and try again",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Obx(
                                  () => ElevatedButton(
                                    onPressed:
                                        controller.isLoading.value == true
                                            ? null
                                            : () => controller.setupApp(),
                                    child: const Text("Try again"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ), (user) {
        return RefreshIndicator(
          displacement: 250,
          backgroundColor: prime,
          color: second,
          strokeWidth: 3,
          triggerMode: RefreshIndicatorTriggerMode.onEdge,
          onRefresh: () async {
            if (currentIndex == 1) {
              await controller.getSavedPost();
            }
            if (currentIndex == 2) {
              await notificationController.getNotification();
            }
            if (currentIndex == 3) {
              await controller.getOrders();
            }
          },
          child: Scaffold(
            appBar: MainAppBar(
              currentIndex: currentIndex,
              height: currentIndex == 4 ? 246 : 63,
              bgColor: currentIndex != 4 ? Colors.white : bgGray,
              statusBarColor: currentIndex != 4 ? Colors.white : bgGray,
            ),
            body: views[currentIndex],
            bottomNavigationBar: MainNavigationBar(
              currentIndex: currentIndex,
              changeIndex: (value) {
                setState(() {
                  currentIndex = value;
                });
              },
            ),
          ),
        );
      }),
    );
  }
}
