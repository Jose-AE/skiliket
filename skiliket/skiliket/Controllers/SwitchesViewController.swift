//
//  SwitchesViewController.swift
//  skiliket
//
//  Created by Rosa Palacios on 08/10/24.
//

import UIKit

class SwitchesViewController: UIViewController {
    
    var selectedSwitch: NetworkResponse?
    
    @IBOutlet weak var switchNameLabel: UILabel!
    @IBOutlet weak var switchIPLabel: UILabel!
    @IBOutlet weak var switchMACLabel: UILabel!
    @IBOutlet weak var switchTypeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let switchDevice = selectedSwitch {
            switchNameLabel.text = switchDevice.hostname
            switchIPLabel.text = switchDevice.managementIPAddress
            switchMACLabel.text = switchDevice.macAddress
            switchTypeLabel.text = switchDevice.type.rawValue
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
