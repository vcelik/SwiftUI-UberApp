//
//  UserService.swift
//  UberApp
//
//  Created by Volkan Celik on 23/08/2023.
//

import Firebase

class UserService:ObservableObject{
    
    static let shared=UserService()
    @Published var user:User?
    
    init(){
        print("Did init user service")
        fetchUser()
    }
    
    func fetchUser(){
        guard let uid=Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, _ in
            print("Did fetch user from firestore")
            guard let snapshot=snapshot else {return}
            //print("DEBUG:User data is \(data)")
            guard let user=try? snapshot.data(as: User.self) else {return}
            self.user=user
        }
    }
    

}
