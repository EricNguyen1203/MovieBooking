import 'package:cinema_booking_v2/entity/movie.dart';
import 'package:cinema_booking_v2/screen/movie_page.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // Thêm tham số title để có khả năng thay thế tiêu đề

  const MyAppBar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          // Left Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row 1
                Text(
                  title, // Sử dụng tham số title thay thế tiêu đề
                  style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.bold),
                ),
                // Row 2
                const Text(
                  'Movies in Chennai',
                  style: TextStyle(fontSize: 12.0),
                ),
              ],
            ),
          ),
          // Right Column
          const CircleAvatar(
            // Replace with actual user avatar
            backgroundImage: AssetImage('assets/images/images4.jpg'),
          ),
        ],
      ),
    );
  }
}

TextField reuseableTextField(String text, bool isPassword, TextEditingController controller){
  return TextField(
  controller: controller,
  obscureText: isPassword,
  autocorrect: !isPassword,
  style: TextStyle(
    color: Colors.black,),

    decoration: InputDecoration(
      labelText: text,
      labelStyle: TextStyle(color: Colors.grey),
      filled: true,
      fillColor: Colors.white.withOpacity(1.0),
      floatingLabelBehavior: FloatingLabelBehavior.never,
    ),
    keyboardType: isPassword ? TextInputType.visiblePassword : TextInputType.emailAddress,
  );
}

Container singInSignUpButton(BuildContext context, bool isLogin, Function onTap){
  return Container(
    width: 300.0,
    height: 50.0,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      child: Text(
        isLogin ? 'Login' : 'Create Account',
        style: const TextStyle(color: Colors.white),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.pressed)){
              return Colors.grey;
            }
            return Colors.blue;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
          ),
        ),
    ),

  );
}

class GridItem extends StatelessWidget {
  final Movie movie;

  GridItem({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.0,
        child: Column(
          children: [
            Container(
              height: 180.0,
              width: 120.0,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MoviePageScreen(movie: movie)),
                  );
                },
                child: Container(
                  // padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(8.0)), // Điều chỉnh độ cong để bo góc
                    child: Image.network(
                      movie.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 150.0,
              height: 50.0,
              child: ListTile(
                title: Text(
                  movie.name,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                subtitle: Text(
                  movie.time,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 10.0,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}



