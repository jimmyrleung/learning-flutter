import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  // Global key to the FormState of our Form
  final formKey = GlobalKey<FormState>();

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
      validator: (String value) {
        if(!value.contains('@')) {
          return 'Please enter a valid e-mail.';
        }

        // null indicates that the field is valid - it can be omitted
        return null;
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
      validator: (String value) {
        if(value.length < 4) {
          return 'Password must have at least 4 characters.';
        }

        return null;
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      onPressed: () {
        // check all 'validator' property from each children form component
        final bool isValid = formKey.currentState.validate();
        print(isValid);
      },
      child: Text('Login'),
      color: Colors.blue,
    );
  }
}
