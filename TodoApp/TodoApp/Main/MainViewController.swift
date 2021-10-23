//
//  MainViewController.swift
//  TodoApp
//
//  Created by 503512 on 20.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    
// MARK: - Variables
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    var presenter : MainViewPresenterProtocol!
    private var data : [ToDoPresentation] = []
    private var isSorted : Bool  = false
    
// MARK: - Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
      //  self.hideKeyboardWhenTappedAround()
        print(data)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter.didchangeTodo()
    }
// MARK: - IBActions
    
    @IBAction func sortButtonTapped(_ sender: UIButton) {
        print("Basilmadan Once \(sender.isSelected)")
        sender.isSelected = isSorted ? false : true
        print("Button basilinca \(sender.isSelected)")
        presenter.didSortTodo(by: isSorted)
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        sender.isSelected = true
        presenter.didAddTodo()
    }
}
// Presenter delegate gibi ama ben delegate olark presenter dummy oldugu icin  -bir sey uretmedigim icin-  direk view a presenteroutuputlari  verdim
// MARK: - Presenter Delegate - Presenter Outputs
extension MainViewController : MainViewProtocol {
    func handleOutput(_ output: MainViewPresenterOutput) {
        self.tableView.isHidden = false
        switch output {
        case .showToDo(let todoList):
            self.data = todoList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .showSearchTodo(let searchToDoList):
            self.data = searchToDoList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .showDeletedTodo(let deletedTodoList):
            self.data = deletedTodoList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .showUpdatedTodo(let updateTodoList):
            self.data = updateTodoList
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        case .showSortedTodo(let sortedTodoList, let flag):
            self.data = sortedTodoList
            self.isSorted = flag
            self.tableView.reloadData()
        case .showEmptyDataView:
            DispatchQueue.main.async {
                self.tableView.isHidden = true
                self.emptyView.isHidden = false
            }
        }
    }
}

// MARK: - TableView  and SearchBar Protocols
extension MainViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewTableViewCell") as! MainViewTableViewCell
        let item = data[indexPath.row]
        cell.titleLabel.text = item.title
        cell.detailLabel.text = item.detail
        cell.deadlineDateLabel.text = item.deadlineDate
        return cell
    }
}
extension MainViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRow(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Hedefi Sil"
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.didDeleteTodo(at: indexPath)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension MainViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.didSearchTodo(with: searchText)
    }
}
