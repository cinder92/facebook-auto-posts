import 'package:facebook_auto_posts/database/models/posts.dart';
import 'package:facebook_auto_posts/database/schema.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _postCtrl = TextEditingController();
  final PostsModel postsModel = PostsModel();
  String files = "";
  List<PlatformFile>? _paths;
  String error = '';

  void onPostCreatePress() async {
    if (_nameCtrl.text.isEmpty || _postCtrl.text.isEmpty) {
      setState(() {
        error = 'Por favor llena todos los campos';
      });
      return;
    }

    await postsModel.createPost(
      name: _nameCtrl.text,
      content: _postCtrl.text,
      files: files,
    );

    _nameCtrl.clear();
    _postCtrl.clear();
    _paths!.clear();
    setState(() {
      files = "";
    });
  }

  void _deletePost(Posts post) async => await postsModel.deletePost(post: post);

  void pickFiles() async {
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: true,
        onFileLoading: (FilePickerStatus status) => print('Status : $status'),
        allowedExtensions: ['mp4', 'png', 'jpg', 'jpeg', 'webp'],
        lockParentWindow: true,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print('Unsupported operation: ${e.message}');
    } catch (e) {
      print('Error picking files: $e');
    }

    setState(() {
      files = _paths != null ? _paths!.map((e) => e.path).join(';') : '...';
    });
  }

  Widget _renderPosts() {
    return StreamBuilder(
      stream: postsModel.getAll(),
      builder: (_, AsyncSnapshot<List<Posts>> data) {
        if (data.hasError || !data.hasData) {
          return Text(data.error.toString());
        }

        final posts = data.data!;

        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final item = posts[index];
              return Column(
                children: [
                  Card(
                    child: ListTile(
                      title: Text(item.name),
                      trailing: IconButton(
                        icon: const Icon(FluentIcons.delete),
                        onPressed: () => _deletePost(item),
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
        title: Text('Publicaciones de Facebook'),
      ),
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InfoLabel(
              label: 'Título',
              child: TextBox(
                controller: _nameCtrl,
              ),
            ),
            const SizedBox(height: 10),
            InfoLabel(
              label: 'Contenido',
              child: TextBox(
                controller: _postCtrl,
                maxLines: null,
              ),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: pickFiles,
              child: const Text('Agregar Archivos'),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: onPostCreatePress,
              child: const Text('Agregar Publicación'),
            ),
            const SizedBox(height: 10),
            _renderPosts(),
          ],
        ),
      ),
    );
  }
}
