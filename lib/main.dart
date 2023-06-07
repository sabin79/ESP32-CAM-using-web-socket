import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main(List<String> args) {
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: "ESP32-CAM",
      home: Home(
          channel: IOWebSocketChannel.connect("ws://192.168.1.64:81/stream")),
    );
  }
}

class Home extends StatefulWidget {
  final WebSocketChannel channel;
  const Home({super.key, required this.channel});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ESP32-CAM"),
      ),
      body: Container(
        color: Colors.black,
        child: StreamBuilder(
            stream: widget.channel.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              } else {
                return Image.memory(snapshot.data);
              }
            }),
      ),
    );
  }
}
