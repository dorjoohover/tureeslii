import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tureeslii/controllers/main_controller.dart';
import 'package:tureeslii/routes.dart';
import 'package:tureeslii/shared/index.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final controller = Get.put(MainController());

  void initState() {
    super.initState();
    controller.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: origin),
      child: Obx(
        () => controller.myRentRequest.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    if (index == 0) {
                      Get.toNamed(Routes.acceptedOrder);
                    }
                  },
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: OrderCard(
                        data: controller.myRentRequest[index],
                      )),
                ),
                itemCount: controller.myRentRequest.length,
              )
            : const Center(
                child: Text('Танд хүсэлт байхгүй байна'),
              ),
      ),
    );
  }
}
