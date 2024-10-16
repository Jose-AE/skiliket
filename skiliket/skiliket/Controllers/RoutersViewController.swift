//
//  RoutersViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 08/10/24.
//

import UIKit

class RoutersViewController: UIViewController {
    
    var selectedRouter: NetworkResponse?
    
    @IBOutlet weak var routerNameLabel: UILabel!
    @IBOutlet weak var routerIPLabel: UILabel!
    @IBOutlet weak var routerMACLabel: UILabel!
    @IBOutlet weak var routerTypeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let routerDevice = selectedRouter {
            routerNameLabel.text = routerDevice.hostname
            routerIPLabel.text = routerDevice.managementIPAddress
            routerMACLabel.text = routerDevice.macAddress
            routerTypeLabel.text = routerDevice.type.rawValue
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
