//
//  ViewController.swift
//  To-Do List (Pet Project #2)
//
//  Created by Даниил Кирьянчук on 22.07.2022.
//

import UIKit

class MainVC: UIViewController {

    let tableView = UITableView()
    let button = UIButton(type: .custom)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addButtonSetup()
        title = "Today"
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    // MARK: - Setup TableView
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    // MARK: - Button Setup
    
    private func addButtonSetup() {
        button.backgroundColor = .white
        view.addSubview(button)
        button.sizeToFit()
        button.layer.cornerRadius = button.bounds.size.height
        let buttonImage = UIImage(named: "cross")
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(self.buttonPressed), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12).isActive = true
        button.widthAnchor.constraint(equalToConstant: 70).isActive = true
        button.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
    }
    
    @objc func buttonPressed(){
        let secondController = DetailVC()
        navigationController?.pushViewController(secondController, animated: true)
//        addItem(nameItem: "New Item")
//        tableView.reloadData()
    }
}


// MARK: - TableView Datasource Methods

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ToDoItems.count != 0 {
            return ToDoItems.count } else {
                return 10
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath)
        
        cell.textLabel?.text =  ToDoItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none } else {
                tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }


}

