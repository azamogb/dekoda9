import 'package:flutter/material.dart';


class ShareButton extends StatelessWidget {
  final void Function()? onTap;
  const ShareButton({super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const Icon(
        Icons.share,
        color: Colors.grey,
      ),
    );
  }
}
