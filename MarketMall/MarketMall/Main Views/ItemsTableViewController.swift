//
//  ItemsTableViewController.swift
//  MarketMall
//
//  Created by Ваня Науменко on 24.04.23.
//

import UIKit

class ItemsTableViewController: UITableViewController {
    // MARK: Vars
    var category: Category?
    var itemArray: [Item]  = []
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.tableFooterView = UIView()
        self.title = category?.name
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if category != nil {
            loadItems()
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemTableViewCell
         
         cell.generateCell(itemArray[indexPath.row])

         return cell
     }
   
     // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         
         if segue.identifier == "itemToAddItemsSeg" {
             let vc = segue.destination as! AddItemViewController
             vc.category = category!
         }
         
     }
     //MARK: Load Items
    
    private func loadItems() {
        dowloadItemsFromFirebase(category!.id) { (allItems) in
            self.itemArray = allItems
            self.tableView.reloadData()

        }
    }
}
