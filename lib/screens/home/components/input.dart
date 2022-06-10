import 'package:flutter/material.dart';

import '../../../bloc_provider.dart';
import '../../../blocs/home_bloc.dart';
import '../../../constants.dart';
import '../../../responsive.dart';

class Input extends StatelessWidget {
  const Input({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required TextEditingController textController,
  })  : _formKey = formKey,
        _textController = textController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<HomeBloc>(context);

    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Introduce un artículo de prensa",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _textController,
              maxLines: 10,
              decoration: const InputDecoration(filled: true),
            ),
            const SizedBox(height: defaultPadding),
            StreamBuilder<ButtonState>(
              initialData: ButtonState.iddle,
              stream: bloc.buttonState,
              builder: (context, snapshot) => Align(
                alignment: Alignment.topRight,
                child: ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding,
                      vertical: defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: snapshot.data == ButtonState.loading
                      ? null
                      : () {
                          // if (_formKey.currentState.validate()) {
                          // Hide keyboard
                          FocusManager.instance.primaryFocus.unfocus();

                          bloc.predict(_textController.text);
                          // }
                        },
                  icon: snapshot.data == ButtonState.loading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white70,
                            strokeWidth: 2,
                          ),
                        )
                      : Container(),
                  label: const Text("Analizar"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
