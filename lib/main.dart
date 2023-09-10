import 'package:delta_editable_text/editable_text.dart';
import 'package:flutter/material.dart' hide EditableText;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = TextEditingController(text: 'Text');
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          EditableText(
            controller: controller,
            focusNode: focusNode,
            style: Theme.of(context).textTheme.bodyMedium!,
            cursorColor: Colors.red,
            backgroundCursorColor: Colors.red,
            expands: true,
            maxLines: null,
            selectionColor: Colors.black,
          )
        ],
      ),
    );
  }
}
