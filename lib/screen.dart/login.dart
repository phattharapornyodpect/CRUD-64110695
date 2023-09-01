import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import '../madels/config.dart';
import '../madels/users.dart';
import 'home.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  Users user = Users();

  Future<void> login(Users user) async {
    var params = {"email": user.email, "password": user.password};

    var url = Uri.http(Configure.server, "users", params);
    var resp = await http.get(url);
    print(resp.body);
    List<Users> login_result = usersFromJson(resp.body);
    print(login_result.length);
    if (login_result.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('users or password invalid')));
    } else {
      Configure.login = login_result[0];
      Navigator.pushNamed(context, Home.routeName);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
            margin: EdgeInsets.all(10.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  emailInputField(),
                  passwordInputField(),
                  SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      SubmitButton(),
                      SizedBox(
                        width: 10.0,
                      ),
                      BackButton(),
                      SizedBox(
                        width: 10.0,
                      ),
                      registerLink()
                    ],
                  )
                ],
              ),
            )));
  }

  Widget emailInputField() {
    return TextFormField(
      initialValue: 'a@a.com',
      decoration: InputDecoration(
        labelText: 'Email',
        icon: Icon(Icons.email),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is requried';
        }
        if (!EmailValidator.validate(value)) {
          return 'It is not email format';
        }
        return null;
      },
      onSaved: (newValue) => user.email = newValue!,
    );
  }

  Widget passwordInputField() {
    return TextFormField(
      initialValue: '1q2w3e4r',
      obscureText: true,
      decoration:
          InputDecoration(labelText: 'password', icon: Icon(Icons.lock)),
      validator: (value) {
        if (value!.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
      onSaved: (newValue) => user.password = newValue!,
    );
  }

  Widget SubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formkey.currentState!.validate()) {
          _formkey.currentState!.save();
          print(user.toJson().toString());
          login(user); // Corrected function call
        }
      },
      child: Text('Login'),
    );
  }

  Widget BackButton() {
    return ElevatedButton(onPressed: () {}, child: Text('back'));
  }

  Widget registerLink() {
    return InkWell(
      child: const Text('Sign Up'),
      onTap: () {},
    );
  }
}
