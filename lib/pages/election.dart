import 'package:decentralized_voting_application/pages/add_candidate.dart';
import 'package:decentralized_voting_application/pages/authorize_voter.dart';
import 'package:decentralized_voting_application/pages/vote.dart';
import 'package:decentralized_voting_application/services/functions.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class Election extends StatefulWidget {
  final Web3Client ethClient;
  final String electionName;
  const Election({ Key? key, required this.ethClient, required this.electionName }) : super(key: key);

  @override
  State<Election> createState() => _ElectionState();
}

class _ElectionState extends State<Election> {
  Web3Client? ethClient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.electionName + " Election"),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: EdgeInsets.all(14),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    FutureBuilder<List>(
                      future: getNumCandidates(widget.ethClient),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Text(
                          snapshot.data![0].toString(),
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    ),
                    Text('Total Candidates'),
                  ],
                ),

                Column(
                  children: [
                    FutureBuilder<List>(
                      future: getTotalVotes(widget.ethClient),
                      builder: (context, snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Text(
                          snapshot.data![0].toString(),
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      }
                    ),
                    Text('Total Votes'),
                  ],
                ),
              ],
            ),

            SizedBox(height: 50,),

            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.lightBlueAccent[700],
                  textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AddCandidate(ethClient: widget.ethClient,)));
                }, 
                child: Text('Add Candidate')
              ),
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(120, 0, 120, 0),
            ),

            SizedBox(height: 20,),

            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.lightBlueAccent[700],
                  textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AuthorizeVoter(ethClient: widget.ethClient,)));
                }, 
                child: Text('Authorize Voter')
              ),
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(120, 0, 120, 0),
            ),

            SizedBox(height: 20,),

            Container(
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.lightBlueAccent[700],
                  textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> Vote(ethClient: widget.ethClient,)));
                }, 
                child: Text('Vote')
              ),
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(120, 0, 120, 0),
            )
          ],
        ),
      ),
    );
  }
}