//
//  ViewController.swift
//  NetworkingExample
//
//  Created by Josh on 18/11/2019.
//  Copyright © 2019 Dstech. All rights reserved.

import UIKit


class ViewController: UIViewController {
    
    var userList : [User] = []//test    
    
    @IBOutlet weak var tableViewUser: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewUser.delegate = self
        tableViewUser.dataSource = self

       
        RequestManager.instance.requestUserList { (result) in
            switch result {
            case .success(let pageUser):
                print(pageUser)
                self.userList = pageUser.data
                DispatchQueue.main.async {
                    self.tableViewUser.reloadData()
                }
            case .failure(let error):
                print(error)
            }

        }
    }
    
    


}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCellUser") as! UserTableViewCell
        
        let user = userList[indexPath.row]
        cell.labelNome.text = user.firstName
        cell.labelCognome.text = user.lastName
        cell.labelEmail.text = user.email
        
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate{
    
}
