import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tureeslii/shared/constants/colors.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.icon, required this.value});
  final String icon;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 2),
          Text(value,
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

class ItemGlassCard extends StatelessWidget {
  const ItemGlassCard(
      {super.key,
      this.color = itemCardBlue,
      required this.icon,
      this.row = true,
      this.onTap,
      required this.value});
  final String icon;
  final String value;
  final Color color;
  final bool row;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 35,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color.withOpacity(0.8),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
        child: row
            ? Row(
                children: [
                  SvgPicture.asset(icon),
                  const SizedBox(width: 2),
                  Text(value,
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ],
              )
            : SvgPicture.asset(icon),
      ),
    );
  }
}
