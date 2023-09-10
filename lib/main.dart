import 'package:delta_editable_text/editable_text.dart';
import 'package:flutter/material.dart' hide EditableText;
import 'package:flutter/services.dart';

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
  TextEditingDelta lastDelta = const TextEditingDeltaNonTextUpdate(
    oldText: '',
    selection: TextSelection.collapsed(offset: -1),
    composing: TextRange.empty,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DeltaDisplay(delta: lastDelta),
          const Divider(height: 32),
          EditableText(
            controller: controller,
            focusNode: focusNode,
            style: Theme.of(context).textTheme.bodyMedium!,
            cursorColor: Colors.red,
            backgroundCursorColor: Colors.red,
            expands: true,
            maxLines: null,
            selectionColor: Colors.black,
            onDelta: (delta) => setState(() => lastDelta = delta),
          )
        ],
      ),
    );
  }
}

/// From https://github.com/Renzo-Olivares/basic_text_field
class DeltaDisplay extends StatelessWidget {
  const DeltaDisplay({required this.delta});
  final TextEditingDelta delta;

  @override
  Widget build(BuildContext context) {
    const TextStyle textStyle = TextStyle(fontWeight: FontWeight.bold);
    final TextEditingDelta lastTextEditingDelta = delta;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Delta class type: ' + lastTextEditingDelta.runtimeType.toString(),
          style: textStyle,
        ),
        Text(
          'Delta old text: ' + lastTextEditingDelta.oldText,
          style: textStyle,
        ),
        if (lastTextEditingDelta is TextEditingDeltaInsertion)
          Text(
            'Delta inserted text: ' +
                (lastTextEditingDelta as TextEditingDeltaInsertion)
                    .textInserted,
            style: textStyle,
          ),
        if (lastTextEditingDelta is TextEditingDeltaInsertion)
          Text(
            'Delta insertion offset: ' +
                (lastTextEditingDelta as TextEditingDeltaInsertion)
                    .insertionOffset
                    .toString(),
            style: textStyle,
          ),
        if (lastTextEditingDelta is TextEditingDeltaDeletion)
          Text(
            'Delta deleted text: ' +
                (lastTextEditingDelta as TextEditingDeltaDeletion).textDeleted,
            style: textStyle,
          ),
        if (lastTextEditingDelta is TextEditingDeltaDeletion)
          Text(
            'Delta beginning of deleted range: ' +
                (lastTextEditingDelta as TextEditingDeltaDeletion)
                    .deletedRange
                    .start
                    .toString(),
            style: textStyle,
          ),
        if (lastTextEditingDelta is TextEditingDeltaDeletion)
          Text(
            'Delta end of deleted range: ' +
                (lastTextEditingDelta as TextEditingDeltaDeletion)
                    .deletedRange
                    .end
                    .toString(),
            style: textStyle,
          ),
        if (lastTextEditingDelta is TextEditingDeltaReplacement)
          Text(
            'Delta text being replaced: ' +
                (lastTextEditingDelta as TextEditingDeltaReplacement)
                    .textReplaced,
            style: textStyle,
          ),
        if (lastTextEditingDelta is TextEditingDeltaReplacement)
          Text(
              'Delta replacement source text: ' +
                  (lastTextEditingDelta as TextEditingDeltaReplacement)
                      .replacementText,
              style: textStyle),
        if (lastTextEditingDelta is TextEditingDeltaReplacement)
          Text(
            'Delta beginning of replaced range: ' +
                (lastTextEditingDelta as TextEditingDeltaReplacement)
                    .replacedRange
                    .start
                    .toString(),
            style: textStyle,
          ),
        if (lastTextEditingDelta is TextEditingDeltaReplacement)
          Text(
            'Delta end of replaced range: ' +
                (lastTextEditingDelta as TextEditingDeltaReplacement)
                    .replacedRange
                    .end
                    .toString(),
            style: textStyle,
          ),
        Text(
          'Delta beginning of new selection: ' +
              lastTextEditingDelta.selection.start.toString(),
          style: textStyle,
        ),
        Text(
          'Delta end of new selection: ' +
              lastTextEditingDelta.selection.end.toString(),
          style: textStyle,
        ),
        Text(
          'Delta beginning of new composing: ' +
              lastTextEditingDelta.composing.start.toString(),
          style: textStyle,
        ),
        Text(
          'Delta end of new composing: ' +
              lastTextEditingDelta.composing.start.toString(),
          style: textStyle,
        ),
      ],
    );
  }
}
