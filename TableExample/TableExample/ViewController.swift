//
//  ViewController.swift
//  TableExample
//
//  Created by Ildar Usmanov on 11.02.2020.
//  Copyright © 2020 Ildar Usmanov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var dataArray = ["Sveta", "Ildar", "Bob"]

    @IBAction func pushAddAction(_ sender: Any) {
        let alert = UIAlertController(title: "Add elem", message: "ToDo", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField { (textField) in
            textField.placeholder = "New elem"
        }
        let alertAction = UIAlertAction(title: "Add", style: UIAlertAction.Style.default) { (alertAction) in
            self.dataArray.append(alert.textFields![0].text!)
            self.tableView.reloadData()
        }
        
        let alertAction2 = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(alertAction)
        alert.addAction(alertAction2)
        
        present(alert, animated: true, completion: nil)
    }

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }


}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Delete"
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        dataArray.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .bottom)
    }
}
