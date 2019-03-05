//
//  testController.swift
//  TheFantasyApp
//
//  Created by Frank Nardone on 2/18/19.
//  Copyright © 2019 FrankNardone. All rights reserved.
//

import Foundation
import Firebase
import SearchTextField
import CodableFirebase

class testController: UIViewController {

    var players = Array<Player>()
    var overlay : UIView?
    @IBOutlet weak var leftSearchBar: SearchTextField!
    @IBOutlet weak var rightSearchBar: SearchTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getting players data from api
        //Doing all assginment in this function... how do I get this into memory in the call back
        //getPlayersData()
        getPlayersDataFirebase()
        setSearchBoxNames()
    }
    @IBAction func leftSearchBarTextChanged(_ sender: SearchTextField) {
        textChanged(text: sender.text!)
    }
    
    @IBAction func rightSearchBarTextChanged(_ sender: SearchTextField) {
        textChanged(text: sender.text!)
    }
    
    func textChanged(text: String){
        print(text)
        
        
    }
    
    //Call Public Players Data API
    func getPlayersData(){
        let getPlayers = GetPlayersNetwork();
        getPlayers.execute(onSuccess: getPlayersSuccess, onError: getPlayersError)
    }

    //what to do when we successufully get data back from api
    func getPlayersSuccess(response: [Player]) {
        players = response
        //print(players)
    }

    func getPlayersError(error: Error){
        print(error)
        exit(0)
    }
    
    func setSearchBoxNames(){
        let db = Firestore.firestore()
        let docRef = db.collection("PlayersNames").document("Names")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let playersNames = document.data()?["playersNames"] as! [String]
                self.leftSearchBar.filterStrings(playersNames)
                self.rightSearchBar.filterStrings(playersNames)
            } else {
                //TODO error
            }
        }
    }
    
    func getPlayersDataFirebase(){
        let db = Firestore.firestore()
        
        db.collection("Players").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}

