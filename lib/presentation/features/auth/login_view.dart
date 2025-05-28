import 'package:app/core/di.dart';
import 'package:app/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passControl  = TextEditingController();

  void _onForgotPassword() {
    //   TODO: Forgotten password logic.
  }

  void _onLoginPressed() {
    // TODO: Start login process.
    ref.read(loginViewModelProvider.notifier)
        .login(_emailControl.text, _passControl.text);
  }

  void _onSignUp() {
    // TODO: Redirect to register page.
  }

  @override
  Widget build(BuildContext context) {

    final loginState = ref.watch(loginViewModelProvider);

    ref.listen<AsyncValue<User?>>(loginViewModelProvider, (_,value) {
      value.when(
          data: (user) {
            if(user != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.go('/home');
              });
            }
          },
          error: (e,_) => ScaffoldMessenger
              .of(context)
              .showSnackBar(SnackBar(content: Text("Error: $e"))),
          loading: () {  },
      );
    });

    return Scaffold(
      body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                  child: Column(
                    children: [
                      //Logo and header
                      const SizedBox(height: 40), // padding
                      Image.asset(
                        "assets/images/im_logo.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "iMpreuna",
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Colaborare. Unitate. Incluziune",
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Inter',
                          color: Color.fromRGBO(107, 114, 128, 1),
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 32),

                      //Email & password
                      TextFormField(
                        controller: _emailControl,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "Introdu adresa ta de e-mail.",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Introdu o adresă de e-mail';
                          }
                          if(!RegExp("[a-zA-Z][0-9.a-zA-Z]+@[a-z]+(.[a-z]+){0,3}").hasMatch(value)) {
                            return 'Adresa de e-mail introdusă este invalidă.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passControl,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          labelText: "Parola",
                          hintText: 'Introdu parola ta.',
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if(value == null || value.isEmpty) {
                            return 'Introdu parola ta.';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: (
                          TextButton(
                            onPressed: _onForgotPassword,
                            style: TextButton.styleFrom(
                             foregroundColor: Color.fromRGBO(99, 102, 241, 1),
                            ),
                            child: const Text(
                              "Ai uitat parola?",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400
                              )
                            )
                          )
                        ),
                      ),
                      const SizedBox(height: 30),

                      //Login button
                      SizedBox(
                        width: double.infinity,
                        child: loginState.when<Widget>(
                            data: (_) => ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color.fromRGBO(99, 102, 241, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: _onLoginPressed,
                            child: const Text('Login',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400
                              )
                            ),
                          ),
                          loading: () => const Center(child: CircularProgressIndicator()),
                          error: (_, __) => ElevatedButton(
                          onPressed: _onLoginPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(71, 73, 190, 1.0),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Retry',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400
                              )
                          ),
                        ),
                        )
                      ),
                      const SizedBox(height: 30),
                      Row(
                        children: const [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text('OR'),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),
                      const SizedBox(height: 24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Nu ai cont? ",
                            style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          GestureDetector(
                            onTap: _onSignUp,
                            child: const Text(
                              'Înregistrează-te acum!',
                              style: TextStyle(
                                color: Color.fromRGBO(99, 102, 241, 1),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
              ),
            ),
          )
      )
    );
  }
}
