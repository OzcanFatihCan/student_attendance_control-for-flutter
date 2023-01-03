// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_attendance_control/QRCodeScannerPage.dart';

const primaryColor = Color(0xff21254A);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController loginAnimationController;
  late Animation<double> rotateAnimationValues;

  late Animation<double> shakingAnimationValues;

  var tfUserName = TextEditingController();
  var tfPassword = TextEditingController();
  bool _isChecked = false;

  Future<void> saveInfo(
      String userName, String password, bool rememberMe) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString("userName", userName);
    sp.setString("password", password);
    sp.setBool("rememberMe", rememberMe);
  }

  Future<void> getInfo() async {
    var sp = await SharedPreferences.getInstance();

    setState(() {
      tfUserName.text = sp.getString("userName") ?? "";
      tfPassword.text = sp.getString("password") ?? "";
      _isChecked = sp.getBool("rememberMe") ?? false;
    });
  }

  Future<void> deleteInfo() async {
    var sp = await SharedPreferences.getInstance();
    sp.remove("userName");
    sp.remove("password");
    sp.remove("rememberMe");
  }

  @override
  void initState() {
    super.initState();
    getInfo();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 5000));

    loginAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));

    rotateAnimationValues =
        Tween(begin: 0.0, end: 2 * 3.14).animate(animationController)
          ..addListener(() {
            setState(() {});
          });

    shakingAnimationValues =
        Tween(begin: 0.0, end: 50.0).animate(loginAnimationController)
          ..addListener(() {
            setState(() {});
          });
    animationController.repeat();
  }

  @override
  void dispose() {
    //animasyon bittikten sonra hafızadan siler
    super.dispose();
    animationController.dispose();
    loginAnimationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: Text(""),
        backgroundColor: primaryColor,
        actions: <Widget>[
          new FloatingActionButton(
            child: Text("EN"),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            onPressed: () {},
          )
        ],
      ),
      body: getLoginForm(context),
    );
  }

  Widget getLoginForm(BuildContext context) {
    var txtUserName = TextFormField(
      controller: tfUserName,
      obscureText: false,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(
          Icons.email,
          color: Colors.orange,
        ),
        contentPadding: EdgeInsets.all(15),
        hintText: "Kullanıcı Adı",
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 3, color: Colors.white)),
      ),
    );

    var txtPassword = TextFormField(
      controller: tfPassword,
      obscureText: true,
      style: TextStyle(fontSize: 18),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(
          Icons.password,
          color: Colors.orange,
        ),
        contentPadding: EdgeInsets.all(15),
        hintText: "Şifre",
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );

    var myCheckBox = Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Theme(
                data: Theme.of(context)
                    .copyWith(unselectedWidgetColor: Colors.white),
                child: Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.orange,
                  value: _isChecked,
                  onChanged: ((value) {
                    _isChecked = value!;
                  }),
                ),
              ),
              Text(
                "Beni Hatırla",
                style: TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          ),
        ],
      ),
    );

    var btnLogin = Material(
      borderRadius: BorderRadius.circular(50),
      color: Colors.orange,
      elevation: 15,
      child: MaterialButton(
        onPressed: () async {
          if (tfUserName.text == "admin" && tfPassword.text == "admin") {
            if (_isChecked) {
              await saveInfo(tfUserName.text, tfPassword.text, _isChecked);
            } else {
              await deleteInfo();
            }
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => QRCodeScannerPage()),
            );
          } else {
            for (var i = 0; i < 3; i++) {
              await loginAnimationController
                  .forward()
                  .whenComplete(() => loginAnimationController.reverse());
            }
          }
        },
        minWidth: MediaQuery.of(context).size.width,
        child: Text("Giriş", style: TextStyle(fontSize: 20)),
        padding: EdgeInsets.all(15),
      ),
    );

    return Transform.translate(
      offset: Offset(shakingAnimationValues.value, 0),
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Transform.rotate(
                angle: rotateAnimationValues.value,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.asset(
                    "assets/images/biruni-logo.jpg",
                    width: 200,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Text(
                "Oturum Açınız",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              SizedBox(height: 15),
              txtUserName,
              SizedBox(height: 15),
              txtPassword,
              SizedBox(height: 15),
              myCheckBox,
              SizedBox(height: 15),
              btnLogin,
            ],
          ),
        ),
      ),
    );
  }
}
