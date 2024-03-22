import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatDetailsPage extends StatelessWidget {
  final Map<String, dynamic> cat;

  const CatDetailsPage({Key? key, required this.cat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cat['breedName']),
      ),
      body: SingleChildScrollView(
          child: Stack(
        children: [
          SizedBox(
            child: ClipPath(
              clipper: ClipContainer(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.height,
                child: Image.network(
                  cat['imgThumb'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}

class ClipContainer extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}


// Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16.0),
//               Text(
//                 'Breed Type: ${cat['breedType']}',
//                 style: const TextStyle(
//                     fontSize: 18.0, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8.0),
//               Text.rich(
//                 TextSpan(
//                   text: 'Description: ',
//                   style: const TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   children: [
//                     TextSpan(
//                       text: '${cat['breedDescription']}',
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//               const SizedBox(height: 16.0),
//               Text.rich(
//                 TextSpan(
//                   text: 'Origin: ',
//                   style: const TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   children: [
//                     TextSpan(
//                       text: '${cat['origin']}',
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//               const SizedBox(height: 16.0),
//               Text.rich(
//                 TextSpan(
//                   text: 'Fur Color: ',
//                   style: const TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   children: [
//                     TextSpan(
//                       text: '${cat['furColor']}',
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//               const SizedBox(height: 16.0),
//               Text.rich(
//                 TextSpan(
//                   text: 'Life Span: ',
//                   style: const TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   children: [
//                     TextSpan(
//                       text:
//                           '${cat['minLifeSpan']} - ${cat['maxLifeSpan']} years',
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//               SizedBox(height: 16.0),
//               Text.rich(
//                 TextSpan(
//                   text: 'Weight: ',
//                   style: const TextStyle(
//                       color: Colors.black, fontWeight: FontWeight.bold),
//                   children: [
//                     TextSpan(
//                       text:
//                           '${cat['minWeightPounds']} - ${cat['maxWeightPounds']} pounds',
//                     ),
//                   ],
//                 ),
//                 textAlign: TextAlign.start,
//               ),
//             ],
//           ),