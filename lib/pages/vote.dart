import 'package:decentralized_voting_application/services/functions.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class Vote extends StatefulWidget {
  final Web3Client ethClient;
  
  const Vote({ Key? key, required this.ethClient }) : super(key: key);

  @override
  State<Vote> createState() => _VoteState();
}

class _VoteState extends State<Vote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vote'),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Column(
          children: [
            FutureBuilder<List>(
              future: getNumCandidates(widget.ethClient),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else {
                  if (snapshot.data![0].toInt() == 0) {
                    return Center(
                      child: Text('No Candidates to Vote', textAlign: TextAlign.center,),
                    );
                  }
                  else {
                    return Column(
                      children: [
                        for(int i=0; i<snapshot.data![0].toInt(); i++)
                        FutureBuilder<List>(
                          future: candidateInfo(i, widget.ethClient),
                          builder: (context, candidateSnapshot) {
                            if (candidateSnapshot.connectionState == ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            else {
                              return ListTile(
                                title: Text('Candidate Name: '+candidateSnapshot.data![0][0].toString()),
                                subtitle: Text('Number of Votes: '+candidateSnapshot.data![0][1].toString()),
                                trailing: Container(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: Colors.lightBlueAccent[700],
                                      textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      vote(i, widget.ethClient);
                                      Navigator.pop(context);
                                    }, 
                                    child: Text('Vote')
                                  ),
                                ),
                              );
                            }
                          }
                        )
                      ],
                    );
                  }
                }
              },
            )
          ],
        ),
      ),
    );
  }
}