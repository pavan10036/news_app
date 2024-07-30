import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../bloc/sign_up_bloc/sign_up_cubit.dart';
import '../../../bloc/sign_up_bloc/sign_up_state.dart';
import '../../../constants/color_constants.dart';
import '../../../constants/constant_strings.dart';
import '../../widgets/text_widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool? emailValidate = false;
  bool? passwordValidate = false;
  @override
  void initState() {
    context.read<SignUpCubit>().createUserWithEmailAndPassword(
        emailController.text, passwordController.text);
  }

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
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            Container(
              color: Colors.white,
              child: const TextField(
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: "Name",
                  border: OutlineInputBorder(
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
            BlocConsumer<SignUpCubit, SignUpState>(
              listener: (context, state) {
                if (state is SignUpFailureState) {
                  Fluttertoast.showToast(
                      msg: state.err.toString(),
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
                if (state is SignUpSuccessState) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                if (state is SignUpSuccessState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: InkWell(
                      onTap: () {
                        setState(
                          () {
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
                                  .read<SignUpCubit>()
                                  .createUserWithEmailAndPassword(
                                      emailController.text,
                                      passwordController.text);
                            }
                          },
                        );
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
                                ConstantStrings.signUpString,
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
                  ConstantStrings.alreadyAccString,
                  16,
                  Colors.black,
                  FontWeight.bold,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: TextWidget(
                    "LogIn",
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
