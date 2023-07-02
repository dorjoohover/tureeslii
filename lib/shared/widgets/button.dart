import 'package:flutter/material.dart';

import '../../shared/index.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {Key? key,
      required this.onPressed,
      this.child,
      this.text,
      this.contentColor,
      this.color = prime,
      this.width,
      this.padding = const EdgeInsets.all(13),
      this.height = 56.0,
      this.borderRadius = 6.0,
      this.disabled = false,
      this.shadow = true,
      this.view = true,
      this.loading = false,
      this.border,
      this.disabledColor = second})
      : super(key: key);
  final Widget? child;
  final String? text;
  final Color color;
  final double? width;
  final Color? contentColor;
  final void Function() onPressed;
  final double height;
  final EdgeInsets padding;
  final double borderRadius;
  final bool disabled;
  final bool shadow;
  final Color disabledColor;
  final bool view;
  final BoxBorder? border;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    Color color =
        loading || disabled ? this.color.withOpacity(0.6) : this.color;

    Color contentColor = this.contentColor ?? Colors.white;

    Widget body = GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        width: width,
        height: height,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: border,
            color: color),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: prime,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              side: BorderSide.none,
            ),
            padding: padding,
          ),
          child: IconTheme(
            data: Theme.of(context).iconTheme.copyWith(color: contentColor),
            child: loading
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : text != null
                    ? Text(
                        text!,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: contentColor,
                            ),
                      )
                    : child ?? const SizedBox(),
          ),
        ),
      ),
    );
    return Material(
      color: Colors.transparent,
      child: body,
    );
  }
}

class MainIconButton extends StatelessWidget {
  const MainIconButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.back = false,
      this.forward = false,
      this.child,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.underline,
      this.color = orange});
  final String text;
  final Function() onPressed;
  final Color color;
  final bool back;
  final bool forward;
  final bool? underline;
  final MainAxisAlignment mainAxisAlignment;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        TextButton(
            onPressed: onPressed,
            child: Row(
              children: [
                back
                    ? child ??
                        Icon(
                          Icons.arrow_back_ios,
                          color: color,
                          size: 20,
                        )
                    : const SizedBox(),
                child != null ? space13 : space8,
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                      decoration:
                          underline == true ? TextDecoration.underline : null),
                ),
                child != null ? space13 : space8,
                forward
                    ? child ??
                        Icon(
                          Icons.arrow_forward_ios,
                          color: color,
                          size: 20,
                        )
                    : const SizedBox(),
              ],
            )),
      ],
    );
  }
}

class AdditionCard extends StatelessWidget {
  const AdditionCard({super.key, required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: gray),
        ),
        space4,
        child
      ],
    );
  }
}