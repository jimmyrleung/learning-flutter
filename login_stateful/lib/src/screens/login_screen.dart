import 'package:flutter/material.dart';
import '../mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

// Extending all from State<LoginScreen> and ValidationMixin
class LoginScreenState extends State<LoginScreen> with ValidationMixin {
  // Global key to the FormState of our Form
  final formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),

      // The form field can implicitly identify its children components
      // Material Form component is a stateful component
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            emailField(),
            passwordField(),

            // That container avoid us setting some 'hardcoded' margin into an input
            Container(margin: EdgeInsets.only(top: 15.0)),
            submitButton(),
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-mail',
        hintText: 'your@email.com',
      ),
      validator: validateEmail,
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'your strong password',
      ),
      validator: validatePassword,
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      onPressed: () {
        // trigger and check all 'validator' properties from each children form component
        final bool isValid = formKey.currentState.validate();

        if (isValid) {
          // trigger all 'onSaved' properties from each children form component
          formKey.currentState.save();

          // Now our data has successfully been retrieved and we can
          // safely use that data
          print('E-mail: $email - Password: $password');
        }
      },
      child: Text('Login'),
      color: Colors.blue,
    );
  }
}
