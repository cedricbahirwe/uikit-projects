//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by Cédric Bahirwe on 07/04/2021.
//

import UIKit
import RxSwift
import RxCocoa


struct TableItem {
    var icon: String
    var title: String
}

class MainViewModel {
    var tableItems =  PublishSubject<[TableItem]>()
    
    
    func fetchItems() {
        let items = [
            TableItem(icon: "house", title: "Home"),
            TableItem(icon: "bell", title: "Notifcation"),
            TableItem(icon: "wallet.pass", title: "Wallet"),
            TableItem(icon: "gear", title: "Settings")
        
        ]
        
        tableItems.onNext(items)
        tableItems.onCompleted()
    }
}

class ViewController: UIViewController {
    
    private let tableView: UITableView =  {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    private var viewModel = MainViewModel()
    
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(tableView)
        tableView.frame = view.bounds
        createBindable()
    }
    
    
    @IBAction func didPressAdd(_ sender: Any) {
        let alert = UIAlertController(title: "Add an item", message: nil , preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak alert] _ in
            guard let textField = alert?.textFields else { return }
            let field = textField[0]
            if let val = field.text {
                if let _ = UIImage(systemName: val) {
                    let item = TableItem(icon: val, title: val.capitalized)
                    print(item)
                    self.viewModel.tableItems.onNext([item])
                    self.viewModel.tableItems.onCompleted()
                } else {

                }
            }
            
        }
        alert.addTextField { (textField) in
            confirmAction.isEnabled = false
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main) { (notification) in
                confirmAction.isEnabled = textField.text!.trimmingCharacters(in: .whitespaces).count > 3
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        alert.addAction(confirmAction)
        present(alert, animated: true)
        
    }
    func createBindable() {
        // Bind items to the tableview
        viewModel.tableItems.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, model,cell in
            cell.imageView?.image = UIImage(systemName: model.icon)
            cell.textLabel?.text = model.title
            
        }.disposed(by: bag)
        
        // Bind the selected model
        tableView.rx.modelSelected(TableItem.self).bind() { item in
            print("The Selected Item is", item.title )
        }.disposed(by: bag)
        
        // Fetch the items
        viewModel.fetchItems()
    }


}

