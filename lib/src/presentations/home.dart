import 'package:flutter/material.dart';
import 'package:objectbox_test/src/data/local/local_data_source.dart';
import 'package:objectbox_test/src/data/local/model/profile_model.dart';
import 'package:objectbox_test/src/data/local/model/token_model.dart';
import 'package:objectbox_test/src/domain/token_entity.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final MessageCtrl messages = MessageCtrl(['Initalization:']);

  final TokenDataSource dataSource = TokenDataSource();
  final TextEditingController username = TextEditingController();
  final TextEditingController dateTime = TextEditingController();
  final TextEditingController token = TextEditingController();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('ObjectBox Test'),
          ),
          body: Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: username,
                  decoration: const InputDecoration(label: Text('Username:')),
                ),
                TextFormField(
                  controller: dateTime,
                  decoration: const InputDecoration(label: Text('Datetime:')),
                ),
                TextFormField(
                  controller: token,
                  decoration: const InputDecoration(label: Text('Token:')),
                ),
                ElevatedButton(
                    onPressed: () {
                      dataSource.add(TokenModel(
                          token: token.text,
                          username: username.text,
                          profile: ProfileModel(
                              height: 12, weight: 52, name: 'AAA')));
                    },
                    child: const Text('Save')),
                const Divider(),
                Wrap(
                  runSpacing: 4,
                  spacing: 4,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          messages.clear();
                        },
                        child: const Text('Clear')),
                    ElevatedButton(
                        onPressed: () {
                          StringBuffer buff =
                              StringBuffer('Start: ${DateTime.now()}\n');
                          final List<TokenEntity> data = dataSource.load();
                          buff.writeln('End: ${DateTime.now()}\n-----------');
                          buff.writeln(data.join('\n\n'));
                          messages.commit(buff.toString());
                          data.forEach((element) {
                            print(element.profile);
                          });
                        },
                        child: const Text('Load')),
                    ElevatedButton(
                        onPressed: () {
                          StringBuffer buff =
                              StringBuffer('Start: ${DateTime.now()}\n');
                          buff.writeln('End: ${DateTime.now()}\n-----------');
                          final List<TokenEntity> data =
                              dataSource.where(username.text);
                          buff.writeln(data.join('\n\n'));
                          messages.commit(buff.toString());
                        },
                        child: const Text('Where username')),
                    ElevatedButton(
                        onPressed: () {
                          final List<TokenModel> data =
                              dataSource.where(username.text);
                          if (data.isNotEmpty) {
                            var first = data.first;
                            dataSource.add(TokenModel(
                              token: token.text,
                              username: first.username,
                              expiredDate: first.expiredDate,
                              id: first.id,
                            ));
                            messages.commit('Replace: $first');
                          } else {
                            messages.commit('Replace: nothing');
                          }
                        },
                        child: const Text('Replace token')),
                    ElevatedButton(
                        onPressed: () {
                          final List<TokenModel> data =
                              dataSource.where(username.text);
                          if (data.isNotEmpty) {
                            var first = data.first;
                            dataSource.remove(first);
                            messages.commit('Remove: $first');
                          } else {
                            messages.commit('Remove: nothing');
                          }
                        },
                        child: const Text('Delete')),
                  ],
                ),
                Expanded(
                  child: Container(
                    color: Colors.black,
                    padding: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width,
                    child: ValueListenableBuilder<List<String>>(
                        valueListenable: messages,
                        builder: (context, value, child) {
                          final list = value.reversed.toList();
                          return ListView.builder(
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '>>> ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.apply(color: Colors.white),
                                    ),
                                    Expanded(
                                      child: Text(
                                        list[index],
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.apply(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                );
                              });
                        }),
                  ),
                )
              ],
            ),
          )),
        ),
      );
}

class MessageCtrl extends ValueNotifier<List<String>> {
  MessageCtrl(List<String> value) : super(value);

  void commit(String message) {
    value.add(message);
    notifyListeners();
  }

  void clear() {
    value.clear();
    notifyListeners();
  }
}
