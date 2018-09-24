//
//  ViewController.swift
//  Marvelous
//
//  Created by John McNiffe on 15/08/2018.
//  Copyright © 2018 John McNiffe. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController, UITextFieldDelegate {

    var characterResults: [Character] = []
    var resultsCount = 0

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBAction func goButtonPressed(_ sender: Any) {
        if let character = searchTextField.text {
            Character.characterDetail(for: character) { (results: [Character]) in
                for result in results {
                    self.characterResults.append(result)
                    print("\(result)\n\n")
                }
            self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        tableView.dataSource = self
        tableView.delegate = self
        searchTextField.delegate = self
        
        
        // hide keyboard
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(gestureRecognizer)
    }

    @objc func hideKeyboard(_ gestureRecognizer: UIGestureRecognizer) {
        searchTextField.resignFirstResponder()
        print("Touching!")
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return false
    }
    
    func searchCharacter() {
    }
    
}



extension SelectViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected row \(indexPath)")
    }
}



extension SelectViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath)
        cell.textLabel?.text = characterResults[0].name
        return cell
    }
}
