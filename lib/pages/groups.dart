import 'package:facebook_auto_posts/database/models/groups.dart';
import 'package:facebook_auto_posts/database/schema.dart';
import 'package:fluent_ui/fluent_ui.dart';

class GroupsPage extends StatefulWidget {
  const GroupsPage({super.key});

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _urlCtrl = TextEditingController();
  GroupsModel groupsModel = GroupsModel();

  String error = '';

  void onAccountCreatePress() async {
    if (_nameCtrl.text.isEmpty || _urlCtrl.text.isEmpty) {
      setState(() {
        error = 'Por favor llena todos los campos';
      });
      return;
    }

    await groupsModel.createGroup(
      name: _nameCtrl.text,
      url: _urlCtrl.text,
    );

    _nameCtrl.clear();
    _urlCtrl.clear();
  }

  void _deleteGroup(Groups group) async =>
      await groupsModel.deleteGroup(group: group);

  Widget _renderGroups() {
    return StreamBuilder(
      stream: groupsModel.getAll(),
      builder: (_, AsyncSnapshot<List<Groups>> data) {
        if (data.hasError || !data.hasData) {
          return Text(data.error.toString());
        }

        final accounts = data.data!;

        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final item = accounts[index];
              return Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text(item.name),
                      trailing: IconButton(
                        icon: const Icon(FluentIcons.delete),
                        onPressed: () => _deleteGroup(item),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(
        title: Text('Grupos de Facebook'),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: InfoLabel(
                    label: 'Nombre',
                    child: TextBox(
                      controller: _nameCtrl,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InfoLabel(
                    label: 'Enlace',
                    child: TextBox(
                      controller: _urlCtrl,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: onAccountCreatePress,
              child: const Text('Agregar Grupo'),
            ),
            const SizedBox(height: 10),
            _renderGroups(),
          ],
        ),
      ),
    );
  }
}
