import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class AuthHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool leadingAction;
  final VoidCallback? triggerFunction;

  const AuthHeader({
    super.key,
    required this.leadingAction,
    this.triggerFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      automaticallyImplyLeading: false,
      leading: leadingAction
          ? Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.secondary,
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  style: IconButton.styleFrom(
                    hoverColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    splashFactory: NoSplash.splashFactory,
                    highlightColor: Colors.transparent,
                  ),
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).colorScheme.onSecondary,
                    size: 18,
                  ),
                  onPressed:
                      triggerFunction ??
                      () {
                        Navigator.pop(context);
                      },
                ),
              ),
            )
          : SizedBox.shrink(),
      centerTitle: true,
      title: SizedBox(
        height: 40,
        child: Image.asset(Assets.logoText, fit: BoxFit.contain),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
