import 'package:decentralized_voting_application/services/functions.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class AddCandidate extends StatefulWidget {
  final Web3Client ethClient;

  const AddCandidate({ Key? key, required this.ethClient}) : super(key: key);

  @override
  State<AddCandidate> createState() => _AddCandidateState();
}

class _AddCandidateState extends State<AddCandidate> {
  final candidateName = TextEditingController();

  bool isCandidateNameEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Candidate'),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextFormField(
                controller: candidateName,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Candidate Name',
                  border: OutlineInputBorder(),
                  errorText: isCandidateNameEmpty ? 'Candidate Name is Compulsory' : null
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
                  if(candidateName.text.length > 0) {
                    setState(() {
                      isCandidateNameEmpty = false;
                    });
                    await addCandidate(candidateName.text, widget.ethClient);
                    Navigator.pop(context);
                  }
                  else {
                    setState(() {
                      isCandidateNameEmpty = true;
                    });
                  }
                }, 
                child: Text('Add Candidate')
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