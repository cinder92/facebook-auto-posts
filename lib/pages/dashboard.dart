import 'dart:async';

import 'package:facebook_auto_posts/database/models/accounts.dart';
import 'package:facebook_auto_posts/database/models/groups.dart';
import 'package:facebook_auto_posts/database/models/logger.dart';
import 'package:facebook_auto_posts/database/models/posts.dart';
import 'package:facebook_auto_posts/database/schema.dart';
import 'package:facebook_auto_posts/types/loggerTypes.dart';
import 'package:facebook_auto_posts/utils/scrapper.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  AccountModel accModel = AccountModel();
  GroupsModel groupModel = GroupsModel();
  PostsModel postModel = PostsModel();
  LoggerModel loggerModel = LoggerModel();
  final ScrollController _scrollController = ScrollController();

  Accounts selectedAcc = const Accounts(
    id: 0,
    name: '- Elija -',
    email: '',
    password: '',
  );
  List<Groups> selectedGroups = [];
  Posts selectedPost = const Posts(
    id: 0,
    name: '- Elija -',
    content: '',
    files: "",
  );

  void addGroup(Groups group, bool exists) {
    if (exists) {
      setState(() {
        selectedGroups.remove(group);
      });
      return;
    }

    setState(() {
      selectedGroups = [...selectedGroups, group];
    });
  }

  void onPublishNow() {
    initScrapping(selectedAcc, selectedPost, selectedGroups);
  }

  Widget _renderOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                InfoLabel(
                  label: 'Publicar',
                  child: StreamBuilder(
                    stream: postModel.getAll(),
                    builder: (_, AsyncSnapshot<List<Posts>> data) {
                      if (data.hasError || !data.hasData) {
                        return Text(data.error.toString());
                      }

                      final items = data.data!;
                      return ComboBox(
                        value: selectedPost,
                        items: items
                            .map(
                              (e) => ComboBoxItem(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedPost = value!;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            Column(
              children: [
                InfoLabel(
                  label: 'Con la cuenta',
                  child: StreamBuilder(
                    stream: accModel.getAll(),
                    builder: (_, AsyncSnapshot<List<Accounts>> data) {
                      if (data.hasError || !data.hasData) {
                        return Text(data.error.toString());
                      }

                      final items = data.data!;
                      return ComboBox(
                        value: selectedAcc,
                        items: items
                            .map(
                              (e) => ComboBoxItem(
                                value: e,
                                child: Text(e.name),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedAcc = value!;
                          });
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InfoLabel(label: 'En los grupos'),
                StreamBuilder(
                  stream: groupModel.getAll(),
                  builder: (_, AsyncSnapshot<List<Groups>> data) {
                    if (data.hasError || !data.hasData) {
                      return Text(data.error.toString());
                    }

                    final items = data.data!;
                    return SizedBox(
                      height: 100,
                      width: 170,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: items.length,
                        itemBuilder: (_, index) {
                          final item = items[index];
                          final isChecked = selectedGroups.contains(item);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                content: Text(item.name),
                                checked: isChecked,
                                onChanged: (_) {
                                  addGroup(item, isChecked);
                                },
                              ),
                              const SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        FilledButton(
          onPressed: onPublishNow,
          child: const Text('Publicar ahora'),
        ),
      ],
    );
  }

  Widget _renderLogs() {
    return StreamBuilder(
        stream: loggerModel.getAll(),
        builder: (_, AsyncSnapshot<List<Logger>> data) {
          if (data.hasError || !data.hasData) {
            return Text(data.error.toString());
          }

          Timer.periodic(const Duration(milliseconds: 250), (timer) {
            if (mounted) {
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent);
            } else {
              timer.cancel();
            }
          });

          final logs = data.data!;

          return Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                controller: _scrollController,
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final item = logs[index];

                  final messageType = item.type.toUpperCase();
                  final messageColor = logsColor.entries
                      .firstWhere((element) => element.key.name == messageType);

                  String formattedDate =
                      DateFormat.MMMMd().add_jm().format(item.date);

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '[$formattedDate] ${item.name}',
                        style: TextStyle(
                          color: messageColor.value,
                          fontSize: 13.0,
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  );
                },
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Facebook Auto-posts'),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: SizedBox(
              width: double.infinity,
              height: 210,
              child: _renderOptions(),
            ),
          ),
          _renderLogs(),
        ],
      ),
    );
  }
}
