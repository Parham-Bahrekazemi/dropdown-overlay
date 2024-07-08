import 'package:drop_down_widget/model/user_model.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/svg.dart';

class OverlayButton extends StatelessWidget {
  const OverlayButton(
      {super.key,
      required this.selectedUser,
      required this.overlayController,
      this.onTap});

  final List<UserModel>? selectedUser;
  final OverlayPortalController overlayController;

  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return selectedUser != null && selectedUser!.isNotEmpty
        ? selectedUser!.length > 1
            ? MuiltiUserSelectedWidget(
                overlayController: overlayController,
                selectedUser: selectedUser)
            : SingleUserSelected(
                overlayController: overlayController,
                selectedUser: selectedUser,
                onTap: onTap)
        : TextButton(
            onPressed: overlayController.toggle,
            child: const Text(
              'Select Assign',
              style: TextStyle(
                color: Color(0xff0253E8),
                fontSize: 13,
              ),
            ),
          );
  }
}

class SingleUserSelected extends StatelessWidget {
  const SingleUserSelected({
    super.key,
    required this.overlayController,
    required this.selectedUser,
    required this.onTap,
  });

  final OverlayPortalController overlayController;
  final List<UserModel>? selectedUser;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: overlayController.toggle,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffEFF1F2),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 172,
              minWidth: 172,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Image.asset(
                    selectedUser?[0].avatar ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  selectedUser?[0].name ?? '',
                  style: const TextStyle(color: Colors.black),
                ),
                const Spacer(),
                InkWell(
                  onTap: onTap,
                  child: SvgPicture.asset(
                    'assets/images/cancel.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MuiltiUserSelectedWidget extends StatelessWidget {
  const MuiltiUserSelectedWidget({
    super.key,
    required this.overlayController,
    required this.selectedUser,
  });

  final OverlayPortalController overlayController;
  final List<UserModel>? selectedUser;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: overlayController.toggle,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffEFF1F2),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 190,
              minWidth: 190,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 90,
                  child: Stack(
                    children: [
                      Image.asset(selectedUser![0].avatar),
                      Positioned(
                        left: 20,
                        child: Image.asset(selectedUser![1].avatar),
                      ),
                      if (selectedUser!.length > 2)
                        Positioned(
                          left: 40,
                          child: Image.asset(selectedUser![2].avatar),
                        ),
                      if (selectedUser!.length > 3)
                        Positioned(
                          left: 60,
                          child: Image.asset(selectedUser![3].avatar),
                        ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '${selectedUser?.length} Assigned',
                  style: const TextStyle(
                    color: Color(0xff637381),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(width: 12),
                SvgPicture.asset(
                  'assets/images/arrow_down.svg',
                  width: 16,
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
