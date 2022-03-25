import 'package:decentralized_voting_application/pages/election.dart';
import 'package:decentralized_voting_application/services/functions.dart';
import 'package:decentralized_voting_application/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final electionName = TextEditingController();

  Client? httpClient;
  Web3Client? ethClient;

  bool isElectioNameEmpty = false;

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voting Application'),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextFormField(
                controller: electionName,
                decoration: InputDecoration(
                  labelText: 'Election Name',
                  border: OutlineInputBorder(),
                  errorText: isElectioNameEmpty ? 'Election Name is Compulsory' : null
                ),
              ),
              padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
            ),

            SizedBox(height: 20,),

            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.lightBlueAccent[700],
                  textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  if(electionName.text.length > 0) {
                    setState(() {
                      isElectioNameEmpty = false;
                    });
                    await startElection(electionName.text, ethClient!);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> Election(ethClient: ethClient!, electionName: electionName.text)));
                  }
                  else {
                    setState(() {
                      isElectioNameEmpty = true;
                    });
                  }
                }, 
                child: Text('Start Election')
              ),
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            )
          ],
        ),
      ),
    );
  }
}