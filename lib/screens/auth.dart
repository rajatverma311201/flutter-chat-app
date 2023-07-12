import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = false;
  String _emailAddress = '';
  String _password = '';

  void _submitForm() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      // print(_emailAddress);
      // print(_password);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Processing Auth Data'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        // shape: BeveledRectangleBorder(
        //   borderRadius: BorderRadius.circular(0),
        // ),
        title: const Text(
          'Auth Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                    child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Email Address'),
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (newValue) => _emailAddress = newValue!,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          autocorrect: false,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return 'Password must be atleast 6 characters long';
                            }
                            return null;
                          },
                          onSaved: (newValue) => _password = newValue!,
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            shadowColor: Colors.grey,
                            foregroundColor: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 8),
                          ),
                          child: Text(
                            _isLogin ? 'Login' : 'Signup',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(_isLogin
                              ? 'Create an account'
                              : 'I Already have an account'),
                        )
                      ],
                    ),
                  ),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
