import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../edit_note_screen/edit_note.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String titlebody = 'Title';
  String contentbody = 'Content';

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body,
      floatingActionButton: _floatingActionButton,
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: const Text('Note App'),
    );
  }

  Widget get _body {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _cellview,
        ],
      ),
    );
  }

  Widget get _floatingActionButton {
    return FloatingActionButton(
      onPressed: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const EditNote(),
          ),
        );
        loadData();
      },
      child: const Icon(Icons.add),
    );
  }

  Widget get _cellview {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditNote(
              title: titlebody,
              content: contentbody,
            ),
          ),
        );
        loadData();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.blue,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      titlebody,
                      textAlign: TextAlign.start,
                      style: textStyle(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  contentbody,
                  maxLines: 7,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  TextStyle textStyle() {
    return const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );
  }

  loadData() async {
    var sharedPref = await SharedPreferences.getInstance();
    titlebody = sharedPref.getString('title') ?? "wirte title";
    contentbody = sharedPref.getString('content') ?? "write content";
    setState(() {});
  }
}
