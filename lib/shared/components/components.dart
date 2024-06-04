
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../modules/news_app/web_view/web_view_screen.dart';
import '../styles/colors.dart';

Widget DefaultButton({
  double width = double.infinity,
  Color background = defaultColor,
  required String text,
  required Function function,
  double radius = 10,
}) {
  return Container(
    width: width,
    height: 40.0,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: MaterialButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget DefaultTextFeild({
  required TextEditingController controller,
  required TextInputType type,
  required FormFieldValidator validate,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  required String label,
  IconData? prefix,
  Widget? suffix,
  bool obscure = false,
  bool isEnabled = true,
  bool show = false,
  Color color = Colors.white,
  bool readOnly=false,
}) =>
    TextFormField(
      onTap: () {
        onTap!();
      },
      onChanged: (value) {
        onChange!(value);
      },
      enabled: isEnabled,
      controller: controller,
      validator: validate,
      keyboardType: type,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      readOnly:readOnly,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),

        prefixIcon: Icon(prefix),
        suffixIcon: suffix,

      ),
    );


Widget buildArticalItem(article, context) => InkWell(
      onTap: () {
        String temp = article['url'];
        navigateTo(context, WebViewScreen(temp));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${article['title']} ',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 14,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast(String text) => Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white,
      fontSize: 16.0,
    );
