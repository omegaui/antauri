import 'package:antauri/app/computer/domain/entities/desktop_app_entity.dart';
import 'package:antauri/app/computer/presentation/computer_state_controller.dart';
import 'package:antauri/app/computer/presentation/widgets/app_card_widget.dart';
import 'package:antauri/app/computer/presentation/widgets/header_bar.dart';
import 'package:antauri/config/resources/app_assets.dart';
import 'package:antauri/config/themes/app_text_theme.dart';
import 'package:antauri/config/themes/widgets/search_field_decorations.dart';
import 'package:antauri/config/themes/window/frame_decorations.dart';
import 'package:antauri/core/storage/runtime_storage.dart';
import 'package:antauri/utils/extras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

enum FilterMode {
  none,
  legacy,
  user,
  flatpak,
  snap,
}

class ComputerLoadedStateView extends StatefulWidget with FrameDecorations {
  const ComputerLoadedStateView({super.key, required this.controller});

  final ComputerStateController controller;

  @override
  State<ComputerLoadedStateView> createState() =>
      _ComputerLoadedStateViewState();
}

class _ComputerLoadedStateViewState extends State<ComputerLoadedStateView> {
  final _storage = Get.find<RuntimeStorage>();
  List<DesktopAppEntity> _apps = [];
  final _focusNode = FocusNode();

  // filter tools
  FilterMode _filterMode = FilterMode.none;
  final _searchController = TextEditingController();
  String _category = "Any";
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _apps = _storage.allApps.where((e) => e.isApplication()).toList();
    Set<String> categories = {};
    for (var e in _apps) {
      if (e.categories.isNotEmpty) {
        for (var c in e.categories) {
          if (c.isNotEmpty) {
            categories.add(c);
          }
        }
      }
    }
    _categories = categories.toList();
    _categories.sort();
    _categories = ["Any", ..._categories];
    doLater(() {
      _focusNode.requestFocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    final apps = _apps.where((e) {
      switch (_filterMode) {
        case FilterMode.none:
          return true;
        case FilterMode.legacy:
          return !e.id.contains('/flatpak') &&
              !e.id.contains('/snap') &&
              !e.id.contains('/.local');
        case FilterMode.user:
          return e.id.contains('/.local');
        case FilterMode.flatpak:
          return e.id.contains('/flatpak');
        case FilterMode.snap:
          return e.id.contains('/snap');
      }
    }).where((e) {
      if (_category == 'Any') {
        return true;
      }
      return e.categories.join(" ").isCaseInsensitiveContains(_category);
    }).where((e) {
      return "${e.name}${e.comment}${e.keywords.join(' ')}"
          .isCaseInsensitiveContains(_searchController.text);
    });
    return Scaffold(
      backgroundColor: FrameDecorations.backgroundColor,
      appBar: HeaderBar.create(
        title: "Modify Installed Applications",
        subTitle: "these are apps installed on your computer",
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Gap(110),
                  if (apps.isNotEmpty) ...[
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        runAlignment: WrapAlignment.center,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ...apps.map(
                            (e) {
                              return AppCardWidget(
                                entity: e,
                                onPressed: () {
                                  widget.controller.viewApp(e);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (apps.isEmpty) ...[
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            child: Lottie.asset(
                              AppAssets.emptySpaceAnimation,
                              width: 450,
                            ),
                          ).animate().fadeIn(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              "Did you know? ${TipAndTricks.getRandomTip()}",
                              style: ConfigurableTextStyle.withFontSize(14)
                                  .makeBold()
                                  .withColor(Colors.grey.shade800),
                            ),
                          ).animate().slideY(
                                begin: 1,
                                end: 0,
                              ),
                          const Gap(10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F0F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _findEmptyCause(),
                              style: ConfigurableTextStyle.withFontSize(14)
                                  .makeBold()
                                  .withColor(Colors.grey.shade800),
                            ),
                          ).animate().slideY(
                                begin: 1,
                                end: 0,
                              ),
                        ],
                      ),
                    ),
                  ],
                  const Gap(10),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 100,
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: TextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      maxLines: 1,
                      style: ConfigurableTextStyle.withFontSize(14),
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: SearchFieldDecorations
                          .searchFieldInputDecoration
                          .copyWith(
                        labelText: "Search installed apps",
                        labelStyle:
                            ConfigurableTextStyle.withFontSize(14).makeMedium(),
                        hintText: "Find by name, keywords or description",
                      ),
                    ),
                  ),
                  ButtonBar(
                    children: [
                      ChoiceChip(
                        label: ConfigurableTextStyle.generate("All Apps", 14),
                        selected: _filterMode == FilterMode.none,
                        onSelected: (value) {
                          setState(() {
                            _filterMode = FilterMode.none;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: ConfigurableTextStyle.generate("Legacy", 14),
                        selected: _filterMode == FilterMode.legacy,
                        onSelected: (value) {
                          setState(() {
                            _filterMode = FilterMode.legacy;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: ConfigurableTextStyle.generate("User", 14),
                        selected: _filterMode == FilterMode.user,
                        onSelected: (value) {
                          setState(() {
                            _filterMode = FilterMode.user;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: ConfigurableTextStyle.generate("Flatpak", 14),
                        selected: _filterMode == FilterMode.flatpak,
                        onSelected: (value) {
                          setState(() {
                            _filterMode = FilterMode.flatpak;
                          });
                        },
                      ),
                      ChoiceChip(
                        label: ConfigurableTextStyle.generate("Snaps", 14),
                        selected: _filterMode == FilterMode.snap,
                        onSelected: (value) {
                          setState(() {
                            _filterMode = FilterMode.snap;
                          });
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Tooltip(
                          message: "Switch Categories",
                          child: DropdownButton(
                            value: _category,
                            focusColor: Colors.blue,
                            icon: const Icon(
                              Icons.category,
                            ),
                            items: [
                              ..._categories.map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    "${e.capitalize}",
                                    style:
                                        ConfigurableTextStyle.withFontSize(14),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (value) {
                              setState(() {
                                _category = value ?? "Any";
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _findEmptyCause() {
    String cause = "No";
    switch (_filterMode) {
      case FilterMode.none:
        break;
      case FilterMode.legacy:
        cause += " Legacy";
      case FilterMode.user:
        cause += " User Installed";
      case FilterMode.flatpak:
        cause += " Flatpak";
      case FilterMode.snap:
        cause += " Snap";
    }
    cause += " Apps found";
    if (_searchController.text.isNotEmpty) {
      cause += " for search query \"${_searchController.text}\"";
    }
    if (_category != 'Any') {
      cause += " in category \"$_category\"";
    }

    return cause;
  }
}
