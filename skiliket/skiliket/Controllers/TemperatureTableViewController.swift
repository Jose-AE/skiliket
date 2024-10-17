//
//  TemperatureTableViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 10/10/24.
//

import UIKit
import SwiftUI


class TemperatureTableViewController: UITableViewController {
    var temperatures = [Temperature]()
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        timer = Timer.scheduledTimer(timeInterval: 20.0, target: self, selector: #selector(fetchTemperature), userInfo: nil, repeats: true)
    }
    @objc func fetchTemperature() {
        guard let url = URL(string: "http://localhost:8000/temperature") else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, error == nil else { return }

            do {
                print(data)
                if let temperaturePT = try? JSONDecoder().decode(TemperaturePT.self, from: data) {
                    DispatchQueue.main.async {
                        self.actualizarTablaCon(temperaturePT)
                    }
                } else {
                    print("No se pudo decodificar el JSON")
                }

            } catch {
                print("Error al decodificar los datos: \(error)")
            }
        }

        task.resume()
    }
    func actualizarTablaCon(_ newT: TemperaturePT) {
        let t = Temperature(value: String(newT.value), timeStamp: Date())
        //Insertar al final
        //temperatures.append(t)
        //insertar al inicio
        temperatures.insert(t, at:0)

        // Insertar una nueva temperatura al final de la tabla
        //let newIndexPath = IndexPath(row: temperatures.count - 1, section: 0)
        //Insertar nueva temperatura al inicio de la tabla
        tableView.reloadData()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return temperatures.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "temperature", for: indexPath)

        // Configure the cell...
        let t = temperatures[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = "\(t.value)"
        content.secondaryText = "\(t.timeStamp)"
        cell.contentConfiguration = content

        return cell
        
    }
    
/*
    @IBSegueAction func openTemperatureChart(_ coder: NSCoder) -> UIViewController? {
        return UIHostingController(coder: coder, rootView: TemperatureLineChartUIView(temperatureData: temperatures))
    }
 */
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
    @IBSegueAction func openTempChart(_ coder: NSCoder) -> UIViewController? {
        let temperatureDataArray = temperatures.map { TemperatureInfo(value: Double($0.value) ?? 0.0, timeStamp: $0.timeStamp) }

        return UIHostingController(coder: coder, rootView: TemperatureChartSwiftUIView(temperaturas: temperatureDataArray))
    }
    
}

