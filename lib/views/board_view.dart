import 'package:flutter/material.dart';

class BoardView extends StatelessWidget {
  const BoardView({super.key});

  static const nums = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.builder(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          return Card(
            color: Colors.blue,
            child: FractionallySizedBox(
              heightFactor: 0.5,
              widthFactor: 0.5,
              child: Center(
                child: Text(
                  '${nums[index]}',
                  style:const TextStyle(fontWeight: FontWeight.bold)
                ),
              ),
            )
          );
        },
        itemCount: 9,
        clipBehavior: Clip.none,
      ),
    );
  }
}