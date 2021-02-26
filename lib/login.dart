import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formstate = GlobalKey<FormState>();
  String email;
  String password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      autovalidateMode: AutovalidateMode.always,
      key: _formstate,
      child: ListView(
        children: <Widget>[
          buildFormEmail(),
          buildFormPassword(),
          buildLoginButton(),
          buildRegisterButton(context),
        ],
      ),
    ));
  }

  ElevatedButton buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      child: Text('Register new account'),
      onPressed: () {
        print('Goto  Regis pagge');
        Navigator.pushNamed(context, '/register');
      },
    );
  }

  ElevatedButton buildLoginButton() {
    return ElevatedButton(
        child: Text('Login'),
        onPressed: () async {
          if (this._formstate.currentState.validate()) {
            print('Valid Form');
            this._formstate.currentState.save();
            await this
                .auth
                .signInWithEmailAndPassword(email: this.email, password: this.password)
                .then((value) {
              print(value.user.emailVerified);
              if (value.user.emailVerified) {
                ScaffoldMessenger.of(this._formstate.currentContext)
                    .showSnackBar(SnackBar(content: Text('Login Pass')));
                    Navigator.pushNamed(context, '/homepage');
              } else {
                ScaffoldMessenger.of(this._formstate.currentContext)
                    .showSnackBar(SnackBar(content: Text('Please verify email')));
              }
            }).catchError((reason) {
              ScaffoldMessenger.of(this._formstate.currentContext)
                  .showSnackBar(SnackBar(content: Text('Login or Password Invalid')));
            });
          } else
            print('Invalid Form');
        });
  }

  TextFormField buildFormPassword() {
    return TextFormField(
      onSaved: (value) {
        this.password = value.trim();
      },
      validator: (value) {
        if (value.length < 8)
          return 'Please Enter more than 8 Character';
        else
          return null;
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'Password',
        icon: Icon(Icons.lock),
      ),
    );
  }

  TextFormField buildFormEmail() {
    return TextFormField(
      onSaved: (value) {
        this.email = value.trim();
      },
      validator: (value) {
        if (value.isEmpty)
          return 'Please fill in E-mail field';
        else
          return null;
      },
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: 'E-mail',
        icon: Icon(Icons.email),
        hintText: 'x@x.com',
      ),
    );
  }
}
