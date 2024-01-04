import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key, this.title, this.content});
  final String? title;
  final String? content;


  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  var titleTEC = TextEditingController();
  var contentTEC = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.title != null) {
      titleTEC.text = widget.title ?? "note edit ";
      contentTEC.text = widget.content ?? " content edit ";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Note Edit'),
      actions: [
        IconButton(
          onPressed: () {
            save();
          },
          icon: const Icon(Icons.save),
        ),
      ],
    );
  }

  Widget get _body {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _inputTextField,
          _inputTextField2,
        ],
      ),
    );
  }

  Widget get _inputTextField {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: titleTEC,
        cursorColor: Colors.amber,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'title',
        ),
      ),
    );
  }

  Widget get _inputTextField2 {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: contentTEC,
          cursorColor: Colors.amber,
          maxLength: 800,
          maxLines: null,
          // expands: true,
          textAlign: TextAlign.start,
          textAlignVertical: TextAlignVertical.top,
          decoration: const InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            hintText: 'content',
          ),
        ),
      ),
    );
  }

  save() async {
    var title = titleTEC.text;
    var content = contentTEC.text;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('title', title);
    prefs.setString('content', content);
    Navigator.of(context).pop();
  }
}
