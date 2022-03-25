import 'package:decentralized_voting_application/services/functions.dart';
import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';

class AuthorizeVoter extends StatefulWidget {
  final Web3Client ethClient;
  const AuthorizeVoter({ Key? key, required this.ethClient}) : super(key: key);

  @override
  State<AuthorizeVoter> createState() => _AuthorizeVoterState();
}

class _AuthorizeVoterState extends State<AuthorizeVoter> {
  final authorizeVoter = TextEditingController();

  bool isAuthorizeVoterEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authorize Voter'),
        automaticallyImplyLeading: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: TextFormField(
                controller: authorizeVoter,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Voter Address',
                  border: OutlineInputBorder(),
                  errorText: isAuthorizeVoterEmpty ? 'Voter Address is Compulsory' : null
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
                  if(authorizeVoter.text.length > 0) {
                    setState(() {
                      isAuthorizeVoterEmpty = false;
                    });
                    await authorisedVoter(authorizeVoter.text, widget.ethClient);
                    Navigator.pop(context);
                  }
                  else {
                    setState(() {
                      isAuthorizeVoterEmpty = true;
                    });
                  }
                }, 
                child: Text('Authorize Voter')
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