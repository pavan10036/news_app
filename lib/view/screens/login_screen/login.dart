import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/view/widgets/text_widget.dart';
import '../../../bloc/login_bloc/login_cubit.dart';
import '../../../bloc/login_bloc/login_state.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constant_strings.dart';
import '../my_news_screen/my_news_screen.dart';
import '../signup_screen/sign_up.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    context.read<LogInCubit>().signInWithEmailAndPassword("", "");
    super.initState();
  }

  bool? emailValidate = false;
  bool? passwordValidate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.secondaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.secondaryColor,
        title: TextWidget(
          ConstantStrings.myNewsString,
          20,
          ColorConstants.primaryColor,
          FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.white,
              child: TextField(
                maxLines: 1,
                controller: emailController,
                decoration: InputDecoration(
                  errorText:
                      emailValidate ?? false ? "Email will not be empty" : null,
                  hintText: "Email",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 5.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              color: Colors.white,
              child: TextField(
                maxLines: 1,
                controller: passwordController,
                decoration: InputDecoration(
                  errorText: passwordValidate ?? false
                      ? "Password will not be empty"
                      : null,
                  hintText: "Password",
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 5.0),
                  ),
                ),
              ),
            ),
            const Spacer(),
            BlocConsumer<LogInCubit, LogInState>(
              listener: (context, state) {
                if (state is LogInFailureState) {
                  Fluttertoast.showToast(
                      msg: state.err.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                if (state is LogInSuccessState) {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                      builder: (context) => const MyNewsScreen(),
                    ),
                  )
                      .then((value) {
                    context
                        .read<LogInCubit>()
                        .signInWithEmailAndPassword("", "");
                  });
                }
              },
              builder: (context, state) {
                if (state is LogInSuccessState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          if (emailController.text == "" &&
                              passwordController.text == "") {
                            emailValidate = true;
                            passwordValidate = true;
                          } else if (emailController.text == "") {
                            emailValidate = true;
                            passwordValidate = false;
                          } else if (passwordController.text == "") {
                            passwordValidate = true;
                            emailValidate = false;
                          } else {
                            passwordValidate = false;
                            emailValidate = false;
                            context
                                .read<LogInCubit>()
                                .signInWithEmailAndPassword(
                                    emailController.text,
                                    passwordController.text);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstants.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: TextWidget(
                                ConstantStrings.logInString,
                                16,
                                Colors.white,
                                FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(
                  ConstantStrings.newHereString,
                  16,
                  Colors.black,
                  FontWeight.bold,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUp(),
                      ),
                    );
                  },
                  child: TextWidget(
                    "SignUp",
                    null,
                    null,
                    FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
