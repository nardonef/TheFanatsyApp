//
//  testController.swift
//  TheFantasyApp
//
//  Created by Frank Nardone on 2/18/19.
//  Copyright © 2019 FrankNardone. All rights reserved.
//

import Foundation
import Firebase

class comparePlayersController: UIViewController {
    
    var players = Array<Player>()
    var overlay : UIView?
    //var db: Firestore!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //db = Firestore.firestore()
        getPlayersNamesFirebase()
        
        //        //overlay
        //        overlay = UIView(frame: view.frame)
        //        overlay!.backgroundColor = UIColor.black
        //        overlay!.alpha = 0.8
        //        view.addSubview(overlay!)
        //
        //        //searchbar hiding
        //        searchBar.isHidden = true
        //        searchBar2.isHidden = true
        //
        //        //getting players data from api
        //        //Doing all assginment in this function... how do I get this into memory in the call back
        //getPlayersData()
    }
    
    func getPlayersData(){
        let getPlayers = GetPlayersNetwork();
        getPlayers.execute(onSuccess: getPlayersSuccess, onError: getPlayersError)
    }
    
    //what to do when we successufully get data back from api
    func getPlayersSuccess(response: [Player]) {
        players = response
        //get array of player names
        var playerNames = [String]()
        for x in response{
            playerNames.append(x.name!)
        }
        print(playerNames)
        
        //add players to dropdown and show
        //        self.searchBar.filterStrings(playerNames)
        //        self.searchBar.isHidden = false
        //        self.searchBar2.filterStrings(playerNames)
        //        self.searchBar2.isHidden = false
        
        //remove overlay
        //overlay?.removeFromSuperview()
    }
    
    func getPlayersError(error: Error) {
        print(error)
        exit(0)
    }
    
    func getPlayersNamesFirebase(){
        let basicQuery = Firestore.firestore().collection("restaurants").limit(to: 3)
        basicQuery.getDocuments { (snapshot, error) in
            if let error = error {
                print("Oh no! Got an error! \(error.localizedDescription)")
                return
            }
            guard let snapshot = snapshot else { return }
            let allDocuments = snapshot.documents
            for restaurantDocument in allDocuments {
                print("I have this restaurant \(restaurantDocument.data())")
            }
        }
    }
    
    
}

