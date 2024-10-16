//
//  SwitchesTableViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 08/10/24.
//

import UIKit

class SwitchesTableViewController: UITableViewController {
    
    var switches: [NetworkResponse] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            do {
                let token = try await Host.getToken()
                let network = try await Network.getNetworkData(token: token!)
                let switchList = network.getSwitches() 
                updateUI(with: switchList)
            } catch {
                displayError(HostError.HostsNotFound, title: "Error al recuperar los switches")
            }
        }
    }

    func updateUI(with switches: [NetworkResponse]) {
        DispatchQueue.main.async {
            self.switches = switches
            self.tableView.reloadData()
        }
    }

    func displayError(_ error: Error, title: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return switches.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchIdentifier", for: indexPath)

        // Configure the cell...
        let switchDevice = switches[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = switchDevice.hostname
        content.secondaryText = switchDevice.managementIPAddress
        cell.contentConfiguration = content
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSwitchDetail" {
            if let destinationVC = segue.destination as? SwitchesViewController,
               let indexPath = tableView.indexPathForSelectedRow {
                let selectedSwitch = switches[indexPath.row]
                destinationVC.selectedSwitch = selectedSwitch
            }
        }
    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
