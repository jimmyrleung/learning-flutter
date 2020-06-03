import 'package:flutter/material.dart';
import '../blocs/bloc.dart';

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          emailField(),
          passwordField(),
          Container(margin: EdgeInsets.only(top: 25.0)),
          submitButton(),
        ],
      ),
    );
  }

  Widget emailField() {
    // The StreamBuilder is a widget that links our Widgets
    // to a specific stream
    return StreamBuilder(
      // The stream we want to link to our textField
      stream: bloc.email,

      // The function that build and re-build our component
      // whenever the stream has an update
      // The snapshot has the value that came across the stream
      // including errors
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'your@email.com',
            labelText: 'E-mail',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'your password',
            labelText: 'Password',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget submitButton() {
    return RaisedButton(
      onPressed: () {},
      child: Text('Login'),
      color: Colors.blue,
    );
  }
}
