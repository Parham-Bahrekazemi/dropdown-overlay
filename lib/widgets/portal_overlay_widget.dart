import 'package:drop_down_widget/constant/get_user_list.dart';
import 'package:drop_down_widget/model/user_model.dart';
import 'package:drop_down_widget/widgets/overlay_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PortalOverlay extends StatefulWidget {
  const PortalOverlay({super.key, required this.overlayController});

  final OverlayPortalController overlayController;

  @override
  State<PortalOverlay> createState() => _PortalOverlayState();
}

class _PortalOverlayState extends State<PortalOverlay> {
  List<UserModel> listUser = <UserModel>[
    UserModel(
      name: 'Gustavo Calzoni',
      avatar: 'assets/images/1.jpg',
    ),
    UserModel(
      name: 'James George',
      avatar: 'assets/images/2.jpg',
    ),
    UserModel(
      name: 'Ahmad Dias',
      avatar: 'assets/images/3.jpg',
    ),
    UserModel(
      name: 'Alfonso Westervelt',
      avatar: 'assets/images/4.jpg',
    ),
    UserModel(
      name: 'Cooper Carder',
      avatar: 'assets/images/5.jpg',
    ),
    UserModel(
      name: 'Ahmad Culhane',
      avatar: 'assets/images/6.jpg',
    ),
    UserModel(
      name: 'Brandon Rosser',
      avatar: 'assets/images/7.jpg',
    ),
    UserModel(
      name: 'Cristofer Calzoni',
      avatar: 'assets/images/8.jpg',
    ),
  ];

  late List<bool> listIsSelected =
      List.generate(listUser.length, (int index) => false);

  Future<void> search(String keyWord) async {
    List<UserModel> userResultList = [];

    List<UserModel> result = getData();
    setState(() {
      listUser = result;
    });

    if (keyWord.isEmpty) {
      List<UserModel> result = getData();
      setState(() {
        listUser = result;
      });
    } else {
      userResultList = listUser
          .where((a) => a.name.toLowerCase().contains(keyWord.toLowerCase()))
          .toList();

      setState(() {
        listUser = userResultList;
      });
    }
  }

  List<UserModel>? selectedUser = [];

  TextEditingController serachController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          OverlayPortal(
            controller: widget.overlayController,
            overlayChildBuilder: (context) {
              return Positioned(
                right: 30,
                top: 150,
                child: Container(
                  width: 292,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xffEFF1F2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 3),
                        child: SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: serachController,
                            onChanged: (value) {
                              // search(value);
                            },
                            decoration: InputDecoration(
                              prefixIcon: Padding(
                                padding: const EdgeInsets.all(9),
                                child: SvgPicture.asset(
                                    'assets/images/search.svg'),
                              ),
                              hintText: 'Search in list',
                              hintStyle: const TextStyle(
                                color: Color(0xff828F9A),
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: const Color(0xffFAFAFA),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffEFF1F2),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffEFF1F2),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // if (selectedUser != null && selectedUser!.isNotEmpty)
                      //   const Padding(
                      //     padding: EdgeInsets.only(top: 16, left: 16),
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Assinged',
                      //           style: TextStyle(
                      //             color: Color(0xff637381),
                      //             fontSize: 13,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      Expanded(
                        flex: 3,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listUser.length,
                          itemBuilder: (context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  top: 16, left: 16, right: 16),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    listIsSelected[index] =
                                        !listIsSelected[index];

                                    if (listIsSelected[index]) {
                                      selectedUser?.add(listUser[index]);

                                      widget.overlayController.toggle();
                                    } else {
                                      selectedUser?.remove(listUser[index]);
                                      widget.overlayController.toggle();
                                    }
                                  });
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 25,
                                      height: 25,
                                      child: Image.asset(
                                        listUser[index].avatar,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      listUser[index].name,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                    if (listIsSelected[index]) const Spacer(),
                                    if (listIsSelected[index])
                                      SvgPicture.asset(
                                        'assets/images/cancel.svg',
                                        width: 16,
                                        height: 16,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: OverlayButton(
              selectedUser: selectedUser,
              overlayController: widget.overlayController,
              onTap: () {
                setState(() {
                  listIsSelected =
                      List.generate(listUser.length, (int index) => false);

                  selectedUser = [];
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
