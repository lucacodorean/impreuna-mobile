import 'package:app/core/di.dart';
import 'package:app/domain/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final TextEditingController _nameControl = TextEditingController();
  final TextEditingController _emailControl = TextEditingController();
  final TextEditingController _passControl  = TextEditingController();
  final TextEditingController _confirmedControl = TextEditingController();

  @override
  void dispose() {
    _emailControl.dispose();
    _passControl.dispose();
    _confirmedControl.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    ref.read(registerViewModelProvider.notifier)
      .register(
      _nameControl.text, _emailControl.text,
      _passControl.text, _confirmedControl.text
    );

    ref.read(loginViewModelProvider.notifier)
      .login(_emailControl.text, _passControl.text);
  }

  void _onLogin() {
    GoRouter.of(context).go("/login");
  }

  @override
  Widget build(BuildContext context) {

    final registerState = ref.watch(registerViewModelProvider);

    ref.listen<AsyncValue<User?>>(registerViewModelProvider, (_,value) {
      value.when(
        data: (user) {
          if(user != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {

              ref.read(loginStateProvider.notifier).logIn();
              GoRouter.of(context).go('/');
            });
          }

          return Column(
            children: [
              const Text(
                'Înregistrare eșuată. Verifică datele.',
                style: TextStyle(color: Colors.red),
              ) ,
          ]);
        },
        error: (e, _) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error: $e")),
            );
          });
        },
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
                          "Toți pentru unul și unul pentru toți!",
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Inter',
                              color: Color.fromRGBO(107, 114, 128, 1),
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        const SizedBox(height: 32),

                        TextFormField(
                          controller: _nameControl,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            labelText: "Numele tău",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _emailControl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "Email",
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
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmedControl,
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: const InputDecoration(
                            labelText: "Confirmă-ți parola",
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
                        const SizedBox(height: 30),

                        //Login button
                        SizedBox(
                            width: double.infinity,
                            child: registerState.when<Widget>(
                              data: (_) => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Color.fromRGBO(99, 102, 241, 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: _onRegisterPressed,
                                child: Text(
                                    registerState is AsyncLoading<User?> ? "Se procesează..." : "Register",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400
                                    )
                                ),
                              ),
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (_, __) => ElevatedButton(
                                onPressed: _onRegisterPressed,
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
                              child: Text('SAU'),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Ai deja cont? ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                            GestureDetector(
                              onTap: _onLogin,
                              child: const Text(
                                'Conectează-te acum!',
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