import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Instagram clone',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Instagram'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedItem = 0;
  bool isLoading = true;

  final List people = [
    {
      'name': 'Otavio Canedo',
      'username': 'otaviocanedo',
      'likes': '100',
      'desc':
          'Desenvolvedor entusiasta em busca de soluções inovadoras! 💻🚀 #CodeLife',
      'img': '',
    },
    {
      'name': 'Gui Miranda',
      'username': 'guimiranda',
      'likes': '110',
      'desc': 'Apaixonado por programação e tecnologia. 💡🖥️ #DevLife',
      'img': '',
    },
    {
      'name': 'Luccas Benedetti',
      'username': 'luccasbenedetti',
      'likes': '120',
      'desc':
          'Explorando o mundo da programação com paixão e dedicação! 🌍👨‍💻',
      'img': '',
    },
    {
      'name': 'Vini Charleaux',
      'username': 'vinicharleaux',
      'likes': '130',
      'desc':
          'Amante do código e da criatividade. 🎵💻 Juntos, podemos criar coisas incríveis!',
      'img': '',
    },
    {
      'name': 'Hiago Martins',
      'username': 'hiagomartins',
      'likes': '140',
      'desc':
          'Focado em aprender e evoluir a cada linha de código! 📚💻 #CodingJourney',
      'img': '',
    },
    {
      'name': 'Danilo Augusto',
      'username': 'daniloaugusto',
      'likes': '150',
      'desc':
          'Vivendo a vida com paixão pela programação! 🌟👨‍💻 #CodePassion',
      'img': '',
    },
    {
      'name': 'Alexandre Ventura',
      'username': 'alexandreventura',
      'likes': '160',
      'desc':
          'Amor pela tecnologia e pela resolução de problemas. 💡🔧 Juntos, podemos criar um futuro digital incrível!',
      'img': '',
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  Future<void> fetchPhotos() async {
    const apiKey = 'U7KfROdTkvR0sWH5PBIxIULBT5KIvoGEeyadd2kbLucDgk1tTJPNW01E';
    const query = 'programing';

    try {
      final response = await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=$query'),
        headers: {'Authorization': apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          for (var i = 0; i < people.length - 1; i++) {
            people[i]['img'] = data['photos'][i]['src']['original'];
          }
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      print('Error fetching photos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.black,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'DancingScript',
              fontSize: 30,
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.chat, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 120,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(people.length, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.account_circle,
                                color: Colors.white,
                                size: 60,
                              ),
                              Text(
                                people[index]['username'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: people.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.account_circle,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  people[index]['name'],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                          Image.network(
                            people[index]['img'],
                            width: double.infinity,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite_border,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(
                                    Icons.chat_bubble_outline_outlined,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: const Icon(Icons.send_outlined,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.bookmark_outline,
                                    color: Colors.white),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                people[index]['likes'] + ' curtidas',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          if (people[index]['desc'] != '')
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 8),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(color: Colors.white),
                                  children: [
                                    TextSpan(
                                      text: people[index]['username'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' ${people[index]['desc']}',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          const Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                'Ver todos os comentários',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const Row(
                            children: [
                              SizedBox(width: 10),
                              Text(
                                'há 5 minutos • Ver tradução',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedItem,
        onTap: (item) => setState(() {
          _selectedItem = item;
        }),
        backgroundColor: Colors.black,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.6),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Inicio',
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: 'Buscar',
            activeIcon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            label: 'Adicionar',
            activeIcon: Icon(Icons.add_box),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'Videos',
            activeIcon: Icon(Icons.movie_creation),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Perfil',
            activeIcon: Icon(Icons.account_circle),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
