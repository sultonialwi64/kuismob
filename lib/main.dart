import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'disease_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text('Plant Disease')
          ),
          backgroundColor: Colors.lightGreen,
          foregroundColor: Colors.white,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: listDisease.length,
                itemBuilder: (context, index) {
                  final Diseases data = listDisease[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => detail(data : data)));
                    },
                    child: Card(
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width /6 ,
                              child: Image(
                                image: NetworkImage(data.imgUrls),
                                height: 75,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              data.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            )
        ),
      ),
    );
  }
}

class detail extends StatelessWidget {
  const detail({super.key, required this.data});
  final Diseases data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Detail Penyakit')
        ),
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
        actions: <Widget>[
          BookmarkButton(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Image.network(data. imgUrls),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                data.name,
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 22
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,20,0,10),
              child: Center(
                child: Column(
                  children: [
                    Text('Disease Name', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                    Text(data.name)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Column(
                  children: [
                    Text('Plant Name', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                    Text(data.plantName)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10,5,0,0),
              child: Center(
                  child: Text('Ciri-Ciri', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),)
              ),
            ),
            SizedBox(
              height: 130,
              child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children:
                  data.nutshell.map((text) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(30,0,30,10),
                      child: Text('- $text'),
                    );
                  }
                  ).toList()
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Column(
                  children: [
                    Text('Disease ID', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                    Text(data.id)
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35,10,35,50),
              child: Center(
                child: Column(
                  children: [
                    Text('Symptoms', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                    Text(data.symptom)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _launcher(data.imgUrls);
        },
        tooltip: 'Open Web',
        child: Icon(Icons.open_in_browser),
        backgroundColor: Colors.lightGreen,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
  Future<void> _launcher(String url) async{
    final Uri _url = Uri.parse(url);
    if(!await launchUrl(_url)){
      throw Exception("gagal membuka url : $_url");
    }
  }
}

class BookmarkButton extends StatefulWidget {
  @override
  _BookmarkButtonState createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  bool _isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
        color: _isBookmarked ? Colors.white : null,
      ),
      onPressed: () {
        setState(() {
          _isBookmarked = !_isBookmarked;
        });
        // Show a snackbar indicating the bookmark state
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isBookmarked ? 'Berhasil menambahkan ke favorit.' : 'Berhasil menghapus dari favorit.'),
            backgroundColor : _isBookmarked ? Colors.lightGreen : Colors.red,
            duration: Duration(seconds: 1),
          ),
        );
      },
    );
  }
}