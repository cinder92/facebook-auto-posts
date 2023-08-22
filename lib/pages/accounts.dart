import 'package:facebook_auto_posts/database/models/accounts.dart';
import 'package:facebook_auto_posts/database/schema.dart';
import 'package:fluent_ui/fluent_ui.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({super.key});

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();
  final TextEditingController _passCtrl = TextEditingController();
  final AccountModel accountModel = AccountModel();
  String error = '';

  void onAccountCreatePress() async {
    if (_nameCtrl.text.isEmpty ||
        _emailCtrl.text.isEmpty ||
        _passCtrl.text.isEmpty) {
      setState(() {
        error = 'Por favor llena todos los campos';
      });
      return;
    }

    await accountModel.createAccount(
      name: _nameCtrl.text,
      email: _emailCtrl.text,
      password: _passCtrl.text,
    );

    _nameCtrl.clear();
    _emailCtrl.clear();
    _passCtrl.clear();
  }

  void _deleteAccount(Accounts acc) async =>
      await accountModel.deleteAccount(acc: acc);

  Widget _renderAccounts() {
    return StreamBuilder(
      stream: accountModel.getAll(),
      builder: (_, AsyncSnapshot<List<Accounts>> data) {
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
                        onPressed: () => _deleteAccount(item),
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
        title: Text('Cuentas de Facebook'),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoLabel(
              label: 'Nombre',
              child: TextBox(
                controller: _nameCtrl,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InfoLabel(
                    label: 'Correo electrónico',
                    child: TextBox(
                      controller: _emailCtrl,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InfoLabel(
                    label: 'Contraseña',
                    child: TextBox(
                      controller: _passCtrl,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: onAccountCreatePress,
              child: const Text('Agregar Cuenta'),
            ),
            const SizedBox(height: 10),
            _renderAccounts(),
          ],
        ),
      ),
    );
  }
}
